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

# main.kit.test.live.strict is true (the default is true): a live
# request that fails, or a live test missing an input it needs,
# fails the test.
# An account with no record for a test to read skips it either way.
use constant LIVE_STRICT => 1;

{
  my $testsdk = BluefinTecsEcrSDK->test(undef, undef);
  my $ent = $testsdk->EcrApi(undef);
  ok(defined $ent, 'ecr_api: create instance');
}

SKIP: {
  skip('feature not present in this SDK: validate', 1)
    unless BluefinTecsEcrConfig::shared_config()->{feature}{validate};
  my $client = BluefinTecsEcrSDK->test(undef, { feature => { validate => { active => 1 } } });
  my $err = eval { $client->EcrApi(undef)->load({ 'amount' => 1 }, undef); undef } // $@;
  is(ref $err ? $err->{code} : undef, 'validate_failed',
    'ecr_api: an invalid request fails with validate_failed');
}

BASIC_FLOW: {
  my $setup = ecr_api_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op (('create', 'load')) {
    my ($_should_skip, $_reason) = BluefinTecsEcrTestRunner::is_control_skipped(
      'entityOp', "ecr_api." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('ecr_api: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
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

  # Whether *_ENTID supplied the idmap, read before env_override consumes
  # it: without it, the ids a live flow binds are the fixture's synthetic ones.
  my $entid_env_raw = $ENV{'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = BluefinTecsEcrTestRunner::env_override({
    'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID' => $idmap,
    'BLUEFIN_TECS_ECR_TEST_LIVE' => 'FALSE',
    'BLUEFIN_TECS_ECR_TEST_EXPLAIN' => 'FALSE',
    'BLUEFIN_TECS_ECR_APIKEY' => '',
  });

  my $idmap_resolved = BluefinTecsEcrHelpers::to_map($env->{'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID'});
  if (!defined $idmap_resolved) {
    $idmap_resolved = BluefinTecsEcrHelpers::to_map($idmap);
  }

  if ((($env->{'BLUEFIN_TECS_ECR_TEST_LIVE'}) || '') eq 'TRUE') {
    my $merged_opts = Voxgig::Struct::merge([
      # FIRST, so the generated fields below win: sdk-test-control.json's
      # test.client.options adds to the live client, it does not redirect it.
      BluefinTecsEcrTestRunner::live_client_options(),
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
