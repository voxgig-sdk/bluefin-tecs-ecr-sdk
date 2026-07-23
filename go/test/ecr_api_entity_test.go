package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go"
	"github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go/core"

	vs "github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go/utility/struct"
)

func TestEcrApiEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.EcrApi(nil)
		if ent == nil {
			t.Fatal("expected non-nil EcrApiEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := ecr_apiBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "ecr_api." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set BLUEFINTECSECR_TEST_ECR_API_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		ecrApiRef01Ent := client.EcrApi(nil)
		ecrApiRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "ecr_api"}, setup.data), "ecr_api_ref01"))

		ecrApiRef01DataResult, err := ecrApiRef01Ent.Create(ecrApiRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		ecrApiRef01Data = core.ToMapAny(ecrApiRef01DataResult)
		if ecrApiRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}

		// LOAD
		ecrApiRef01MatchDt0 := map[string]any{}
		ecrApiRef01DataDt0Loaded, err := ecrApiRef01Ent.Load(ecrApiRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		if ecrApiRef01DataDt0Loaded == nil {
			t.Fatal("expected load result to be non-nil")
		}

	})
}

func ecr_apiBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "ecr_api", "EcrApiTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read ecr_api test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse ecr_api test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"ecr_api01", "ecr_api02", "ecr_api03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("BLUEFINTECSECR_TEST_ECR_API_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"BLUEFINTECSECR_TEST_ECR_API_ENTID": idmap,
		"BLUEFINTECSECR_TEST_LIVE":      "FALSE",
		"BLUEFINTECSECR_TEST_EXPLAIN":   "FALSE",
		"BLUEFINTECSECR_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["BLUEFINTECSECR_TEST_ECR_API_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["BLUEFINTECSECR_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["BLUEFINTECSECR_APIKEY"],
			},
			extra,
		})
		client = sdk.NewBluefinTecsEcrSDK(core.ToMapAny(mergedOpts))
	}

	live := env["BLUEFINTECSECR_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["BLUEFINTECSECR_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
