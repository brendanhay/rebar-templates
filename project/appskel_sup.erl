-module({{projectid}}_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Callbacks
-export([init/1]).

-include("include/{{projectid}}.hrl").

%%
%% API
%%

-spec start_link() -> ignore | {error, _} | {ok, pid()}.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%
%% Callbacks
%%

-spec init([]) -> supervisor().
init([]) ->
    Mod = {{projectid}}_serv,
    Spec = {Mod, {Mod, start_link, []}, permanent, 6000, worker, [Mod]},
    Options = {one_for_all, 3, 20},
    {ok, {Options, [Spec]}}.
