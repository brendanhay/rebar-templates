-module({{projectid}}_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Callbacks
-export([init/1]).

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
    Children = [{{{projectid}}_serv, {{{projectid}}_serv, start_link, []},
                 permanent, 6000, worker, [{{projectid}}_serv]}],
    {ok, {{one_for_all, 3, 20}, Children}}.
