# BluefinTecsEcr SDK utility: prepare_body

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/media.pm"));

package BluefinTecsEcrUtilities;

our %REGISTRY;

$REGISTRY{prepare_body} = sub {
  my ($ctx) = @_;
  return undef unless 'data' eq $ctx->{op}{input};
  return BluefinTecsEcrUtilities::raw_body($ctx->{reqdata})
    if BluefinTecsEcrUtilities::is_raw_request($ctx->{point});
  return $ctx->{utility}{transform_request}->($ctx);
};

1;
