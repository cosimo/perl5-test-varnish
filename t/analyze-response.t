#!perl -T

use strict;
use warnings;
use HTTP::Headers;
use HTTP::Response;
use Test::More;

use_ok('Test::Varnish');

plan tests => 4;

my $tv = Test::Varnish->new();

my $head = HTTP::Headers->new();
$head->push_header('X-Varnish', '123456789');

my $resp = HTTP::Response->new(200, 'OK', $head, '<html/>');
my $is_cached = $tv->analyze_response($resp);

is(
	$is_cached => 0,
	'Varnish header with just request-id means miss or not cacheable'
);

# Header with two IDs means response was cached
$head = HTTP::Headers->new();
$head->push_header('X-Varnish', '123456780 123456789');

$resp = HTTP::Response->new(200, 'OK', $head, '<html/>');
$is_cached = $tv->analyze_response($resp);

is(
	$is_cached => 1,
	'Varnish header with 2 request-ids means cache hit',
);

# No header means no Varnish
$head = HTTP::Headers->new();
$head->push_header('Server', 'Apache/2.2.9');

$resp = HTTP::Response->new(200, 'OK', $head, '<html/>');
$is_cached = $tv->analyze_response($resp);

is(
	$is_cached => 0,
	'No varnish header. Can\'t be cached.',
);

