%% Based on the code from Learn You Some Erlang
%% http://learnyousomeerlang.com/clients-and-servers
%% http://learnyousomeerlang.com/static/erlang/kitty_gen_server.erl

-module(kitty_gen_microservice).
-behaviour(gen_microservice).

-export([start_link/0, order_cat/4, return_cat/2, close_shop/1]).
-export([init/1, monolithic_call/3, modern_async/2, handle_info/2,
         terminate/2, code_change/3]).

-record(cat, {name, color=green, description}).

%%% Client API
start_link() ->
    gen_server:start_link(?MODULE, [], []).

%% Synchronous call
order_cat(Pid, Name, Color, Description) ->
    gen_server:call(Pid, {order, Name, Color, Description}).

%% This call is asynchronous
return_cat(Pid, Cat = #cat{}) ->
    gen_server:cast(Pid, {return, Cat}).

%% Synchronous call
close_shop(Pid) ->
    gen_server:call(Pid, terminate).

%%% Server functions
init([]) -> {ok, []}. %% no treatment of info here!

monolithic_call({order, Name, Color, Description}, _From, Cats) ->
    if Cats =:= [] ->
            {reply, make_cat(Name, Color, Description), Cats};
       Cats =/= [] ->
            {reply, hd(Cats), tl(Cats)}
    end;
monolithic_call(terminate, _From, Cats) ->
    {stop, normal, ok, Cats}.

modern_async({return, Cat = #cat{}}, Cats) ->
    {noreply, [Cat|Cats]}.

handle_info(Msg, Cats) ->
    io:format("Unexpected message: ~p~n",[Msg]),
    {noreply, Cats}.

terminate(normal, Cats) ->
    [io:format("~p was set free.~n",[C#cat.name]) || C <- Cats],
    ok.

code_change(_OldVsn, State, _Extra) ->
    %% No change planned. The function is there for the behaviour,
    %% but will not be used. Only a version on the next
    {ok, State}.

%%% Private functions
make_cat(Name, Col, Desc) ->
    #cat{name=Name, color=Col, description=Desc}.
