#!perl
# EcrApi entity test

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Cwd ();

use BluefinTecsEcrSDK;
require(Cwd::abs_path("$FindBin::Bin/runner.pm"));

{
  my $testsdk = BluefinTecsEcrSDK->test(undef, undef);
  my $ent = $testsdk->EcrApi(undef);
  ok(defined $ent, 'ecr_api: create instance');
}

BASIC_FLOW: {
  my $setup = ecr_api_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op ('create', 'load') {
    my ($_should_skip, $_reason) = BluefinTecsEcrTestRunner::is_control_skipped(
      'entityOp', "ecr_api." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('ecr_api: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
  }
  # The basic flow consumes synthetic IDs from the fixture. In live mode
  # without an *_ENTID env override, those IDs hit the live API and 4xx.
  if ($setup->{synthetic_only}) {
    note('live entity test uses synthetic IDs from fixture - set BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID JSON to run live');
    pass('ecr_api: basic flow skipped (synthetic IDs only)');
    last BASIC_FLOW;
  }
  my $client = $setup->{client};
  my %V;

  # CREATE
  $V{ecr_api_ref01_ent} = $client->EcrApi(undef);
  $V{ecr_api_ref01_data} = BluefinTecsEcrHelpers::to_map(BluefinTecsEcrHelpers::gp(
    BluefinTecsEcrHelpers::gpath($setup->{data}, 'new.ecr_api'), 'ecr_api_ref01'));

  $V{ecr_api_ref01_data_result} = $V{ecr_api_ref01_ent}->create($V{ecr_api_ref01_data}, undef);
  $V{ecr_api_ref01_data} = BluefinTecsEcrHelpers::to_map(ref($V{ecr_api_ref01_data_result}) && $V{ecr_api_ref01_data_result}->can('data_get') ? $V{ecr_api_ref01_data_result}->data_get : $V{ecr_api_ref01_data_result});
  ok(defined $V{ecr_api_ref01_data}, 'ecr_api create: data');

  # LOAD
  $V{ecr_api_ref01_match_dt0} = {};
  $V{ecr_api_ref01_data_dt0_loaded} = $V{ecr_api_ref01_ent}->load($V{ecr_api_ref01_match_dt0}, undef);
  ok(defined $V{ecr_api_ref01_data_dt0_loaded}, 'ecr_api load: data');

}

sub ecr_api_basic_setup {
  my ($extra) = @_;
  BluefinTecsEcrTestRunner::load_env_local();

  my $entity_data_file = Cwd::abs_path(
    "$FindBin::Bin/../../.sdk/test/entity/ecr_api/EcrApiTestData.json");
  my $entity_data = do {
    open my $fh, '<:raw', $entity_data_file or die "Cannot open $entity_data_file: $!";
    local $/;
    Voxgig::Struct::parse_json(<$fh>);
  };

  my $options = {};
  $options->{entity} = $entity_data->{existing};

  my $client = BluefinTecsEcrSDK->test($options, $extra);

  # Generate idmap via transform.
  my $idmap = Voxgig::Struct::transform(
    ['ecr_api01', 'ecr_api02', 'ecr_api03'],
    {
      '`$PACK`' => ['', {
        '`$KEY`' => '`$COPY`',
        '`$VAL`' => ['`$FORMAT`', 'upper', '`$COPY`'],
      }],
    }
  );

  # Detect ENTID env override before env_override consumes it. When live
  # mode is on without a real override, the basic test runs against
  # synthetic IDs from the fixture and 4xx's. Surface this so the test can
  # skip.
  my $entid_env_raw = $ENV{'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = BluefinTecsEcrTestRunner::env_override({
    'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID' => $idmap,
    'BLUEFIN_TECS_ECR_TEST_LIVE' => 'FALSE',
    'BLUEFIN_TECS_ECR_TEST_EXPLAIN' => 'FALSE',
    'BLUEFIN_TECS_ECR_APIKEY' => 'NONE',
  });

  my $idmap_resolved = BluefinTecsEcrHelpers::to_map($env->{'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID'});
  if (!defined $idmap_resolved) {
    $idmap_resolved = BluefinTecsEcrHelpers::to_map($idmap);
  }

  if ((($env->{'BLUEFIN_TECS_ECR_TEST_LIVE'}) || '') eq 'TRUE') {
    my $merged_opts = Voxgig::Struct::merge([
      {
        'apikey' => $env->{'BLUEFIN_TECS_ECR_APIKEY'},
      },
      (Voxgig::Struct::ismap($extra) ? $extra : {}),
    ]);
    $client = BluefinTecsEcrSDK->new(BluefinTecsEcrHelpers::to_map($merged_opts));
  }

  my $live = ((($env->{'BLUEFIN_TECS_ECR_TEST_LIVE'}) || '') eq 'TRUE') ? 1 : 0;
  return {
    'client' => $client,
    'data' => $entity_data,
    'idmap' => $idmap_resolved,
    'env' => $env,
    'explain' => ((($env->{'BLUEFIN_TECS_ECR_TEST_EXPLAIN'}) || '') eq 'TRUE') ? 1 : 0,
    'live' => $live,
    'synthetic_only' => ($live && !$idmap_overridden) ? 1 : 0,
    'now' => BluefinTecsEcrHelpers::now_ms(),
  };
}

done_testing();
