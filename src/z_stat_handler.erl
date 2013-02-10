%%

-module(z_stat_handler).

-export([init/0, update/2]).

-include_lib("zotonic.hrl").


%%
%% Initialize statman.  
%% 
init() ->
    ok = statman_counter:init(),
    ok = statman_gauge:init(),
    ok = statman_histogram:init().
   
% @doc
% 

% counter.
update(#counter{name=Name, op=incr, value=Value}, #stats_from{host=Host, system=System}) ->
    statman_counter:incr({Name, Host, System}, Value);
update(#counter{name=Name, op=decr, value=Value}, #stats_from{host=Host, system=System}) ->
    statman_counter:incr({Name, Host, System}, Value);
update(#counter{name=Name, op=clear, value=Value}, #stats_from{host=Host, system=System}) ->
    statman_counter:set({Name, Host, System}, 0);

% histogram.
update(#histogram{name=Name, value=V}, #stats_from{host=Host, system=System}) ->
    statman_histogram:record_value({Name, Host, System}, V).
