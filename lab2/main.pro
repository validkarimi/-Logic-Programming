% Copyright

implement main
    open core, stdio

class facts - productDb
    product : (integer Id, string Name, string Type).
    client : (integer Id, string Name).
    purchase : (integer Id_client, integer Id_product, integer Cost).

class facts
    s : (real Sum) single.

clauses
    s(0).

class predicates
    product_buy : (string ProdName) nondeterm.
    client_buy : (string Name) nondeterm.
    product_type : (string ProdName) nondeterm.
    client_cash : (string Name) nondeterm.

clauses
    product_buy(X) :-
        product(Id_prod, X, _),
        purchase(Id_client, Id_prod, _),
        client(Id_client, Name),
        write(Name, " покупил ", X),
        nl,
        fail.
    product_buy(X) :-
        product(_, X, _),
        write("Конец списка"),
        nl.

    client_buy(X) :-
        client(Id, X),
        purchase(Id, Id_p, Cost),
        product(Id_p, Name_p, _),
        write(X, " покупал ", Name_p, " за ", Cost),
        nl,
        fail.
    client_buy(X) :-
        client(_, X),
        write("Конец списка"),
        nl.

    product_type(X) :-
        product(_, X, Type),
        write(X, " это ", Type),
        nl.

    client_cash(X) :-
        client(Id, X),
        purchase(Id, _, Cost),
        assert(s(0)),
        s(Sum),
        asserta(s(Sum + Cost)),
        fail.
    client_cash(X) :-
        client(_, X),
        s(Sum),
        write(X, " потратил ", Sum),
        nl.

    run() :-
        console::init(),
        file::reconsult("..\\product.txt", productDb),
        fail.
    run() :-
        product_buy("Bread"),
        fail.
    run() :-
        client_buy("Kirill"),
        fail.
    run() :-
        product_type("Milk"),
        fail.
    run() :-
        client_cash("Nikita"),
        fail.
    run() :-
        _ = readLine().

end implement main

goal
    console::run(main::run).
