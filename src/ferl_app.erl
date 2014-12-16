-module(ferl_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", core_handler, []},
            {"/assets/[...]", cowboy_static, {priv_dir, ferl, "/assets", 
                [{mimetypes, cow_mimetypes, all}]}}
        ]}
    ]),
    cowboy:start_http(my_http_listener, 100, [{port, 8080}],
        [{env, [{dispatch, Dispatch}]}]
    ),
	ferl_sup:start_link().

stop(_State) ->
	ok.
