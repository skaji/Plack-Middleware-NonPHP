use strict;
use warnings;
use utf8;
use Test::More;
use Plack::Test;
use Plack::Builder;
use HTTP::Request::Common;
use Data::Dumper;

my $app = sub { [200,[],["ok"]] };

my $pc_ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36";


test_psgi
    app => builder {
        enable 'NonPHP';
        $app;
    },
    client => sub {
        my $cb = shift;
        my $res;
        $res = $cb->( GET "/" );
        is $res->code, 404;
        $res = $cb->( GET "/", 'user-agent' => $pc_ua );
        is $res->code, 200;
        $res = $cb->( GET "/phpmyadmin", 'user-agent' => $pc_ua );
        is $res->code, 404;
        $res = $cb->( GET "/index.php", 'user-agent' => $pc_ua );
        is $res->code, 404;
        $res = $cb->( GET "/", 'user-agent' => "ZmEu" );
        is $res->code, 404;
    };

done_testing;

