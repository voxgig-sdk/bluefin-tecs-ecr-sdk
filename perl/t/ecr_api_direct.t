#!perl
# EcrApi direct test

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

sub live_ok {
  my ($result) = @_;
  my $status = BluefinTecsEcrHelpers::to_int($result->{status});
  return !defined $result->{err} && $result->{ok} && $status >= 200 && $status < 300;
}

DIRECT_LOAD: {
  my $setup = ecr_api_direct_setup({ 'id' => 'direct01' });
  my ($_should_skip, $_reason) = BluefinTecsEcrTestRunner::is_control_skipped(
    'direct', 'direct-load-ecr_api', $setup->{live} ? 'live' : 'unit');
  if ($_should_skip) {
    note($_reason || 'skipped via sdk-test-control.json');
    pass('direct-load-ecr_api: skipped via sdk-test-control.json');
    last DIRECT_LOAD;
  }
  my $client = $setup->{client};

  my $params = {};
  my $query = {};
  if ($setup->{live}) {
  }
  else {
  }

  my $result = $client->direct({
    'path' => 'version',
    'method' => 'GET',
    'params' => $params,
    'query' => $query,
  });
  if ($setup->{live}) {
    if (!live_ok($result)) {
      BluefinTecsEcrTestRunner::live_miss(LIVE_STRICT, 'direct-load-ecr_api', 'Live load failed: ' . BluefinTecsEcrTestRunner::live_describe($result));
      last DIRECT_LOAD;
    }
    if (!defined $result->{data}) {
      BluefinTecsEcrTestRunner::live_miss(LIVE_STRICT, 'direct-load-ecr_api', 'Live load returned no data: ' . BluefinTecsEcrTestRunner::live_describe($result));
      last DIRECT_LOAD;
    }
    pass('direct-load-ecr_api: live ok');
  }
  else {
    ok(!defined $result->{err}, 'direct-load-ecr_api: no error');
    ok($result->{ok}, 'direct-load-ecr_api: ok');
    is(BluefinTecsEcrHelpers::to_int($result->{status}), 200, 'direct-load-ecr_api: status');
    ok(defined $result->{data}, 'direct-load-ecr_api: data');
    if (Voxgig::Struct::ismap($result->{data})) {
      is($result->{data}{id}, 'direct01', 'direct-load-ecr_api: id');
    }
    is(scalar @{ $setup->{calls} }, 1, 'direct-load-ecr_api: 1 call');
  }
}


sub ecr_api_direct_setup {
  my ($mockres) = @_;
  BluefinTecsEcrTestRunner::load_env_local();

  my $calls = [];

  my $env = BluefinTecsEcrTestRunner::env_override({
    'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID' => {},
    'BLUEFIN_TECS_ECR_TEST_LIVE' => 'FALSE',
    'BLUEFIN_TECS_ECR_APIKEY' => '',
  });

  my $live = ((($env->{'BLUEFIN_TECS_ECR_TEST_LIVE'}) || '') eq 'TRUE') ? 1 : 0;

  if ($live) {
    # live_client_options() FIRST so the generated fields below win:
    # sdk-test-control.json's test.client.options adds to the live client,
    # it does not redirect it (a later key wins in a Perl hash literal).
    my $client = BluefinTecsEcrSDK->new({
      %{ BluefinTecsEcrTestRunner::live_client_options() },
      'apikey' => $env->{'BLUEFIN_TECS_ECR_APIKEY'},
    });
    my $idmap = $env->{'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID'};
    return {
      'client' => $client,
      'calls' => $calls,
      'live' => 1,
      'idmap' => ref $idmap eq 'HASH' ? $idmap : {},
    };
  }

  my $mock_fetch = sub {
    my ($url, $init) = @_;
    push @$calls, { 'url' => $url, 'init' => $init };
    return ({
      'status' => 200,
      'statusText' => 'OK',
      'headers' => {},
      'json' => sub {
        return defined $mockres ? $mockres : { 'id' => 'direct01' };
      },
      'body' => 'mock',
    }, undef);
  };

  my $client = BluefinTecsEcrSDK->new({
    'base' => 'http://localhost:8080',
    'system' => {
      'fetch' => $mock_fetch,
    },
  });

  return {
    'client' => $client,
    'calls' => $calls,
    'live' => 0,
    'idmap' => {},
  };
}

done_testing();
