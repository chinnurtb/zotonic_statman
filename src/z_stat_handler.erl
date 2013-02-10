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
update(#counter{name=Name, op=Op, value=V}, #stats_from{host=Host, system=System}) ->
    case Op of 
        'incr' ->
            statman_counter:incr({Name, Host, System}, V);
        'decr' ->
            statman_counter:incr({Name, Host, System}, V);
        'set' ->
            statman_counter:set({Name, Host, System}, V)
    end;
update(#histogram{name=Name, value=V}, #stats_from{host=Host, system=System}) ->
    statman_histogram:record_value({Name, Host, System}, V);
update(_Stat, []) ->
    ok;
update(Stat, [H|T]) ->
    update(Stat, H),
    update(Stat, T).
    
