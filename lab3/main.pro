implement main
    open core, stdio

class facts - productDb
    product : (integer Id, string Name, string Type).
    client : (integer Id, string Name).
    purchase : (integer Id_client, integer Id_product, integer Cost).

domains
    name_cost = name_cost(string Name, integer Cost).

class predicates  %Вспомогательные предикаты
    длина : (A*) -> integer N.
clauses
    длина([]) = 0.
    длина([_ | T]) = длина(T) + 1.

class predicates
    product_buy : (string ProdName) -> string* Имена_тех_кто_покупал determ.
    client_buy : (string Name) -> string* Названия_товаров determ.
    product_ext_info : (string ProdName) -> name_cost* Информация_о_товаре determ.
    buy_count : (string Name) -> integer Количество determ.

clauses
    product_buy(X) = L :-
        product(Id_p, X, _),
        !,
        L =
            [ N ||
                purchase(Id_client, Id_p, _),
                client(Id_client, N)
            ].

    client_buy(X) = L :-
        client(Id, X),
        !,
        L =
            [ N ||
                purchase(Id, Id_prod, _),
                product(Id_prod, N, _)
            ].

    buy_count(X) = длина(client_buy(X)).

    product_ext_info(X) =
            [ name_cost(Name, Cost) ||
                purchase(Id_client, Id_prod, Cost),
                client(Id_client, Name)
            ] :-
        product(Id_prod, X, _),
        !.

class predicates
    write_name_cost : (name_cost* Name_Cost).
clauses
    write_name_cost(L) :-
        foreach name_cost(Name, Cost) = list::getMember_nd(L) do
            writef("\t%\t%\n", Name, Cost)
        end foreach.

    run() :-
        console::init(),
        file::reconsult("..\\product.txt", productDb),
        fail.
    run() :-
        X = "Cheese",
        write("Те кто покупали ", X, ":\n"),
        L = product_buy(X),
        write(L),
        nl,
        fail.
    run() :-
        X = "Alina",
        L = client_buy(X),
        write("Все покупки ", X, ":\n"),
        write(L),
        write("\tКоличество = "),
        write(buy_count(X)),
        nl,
        fail.
    run() :-
        X = "Meet",
        write_name_cost(product_ext_info(X)),
        nl,
        fail.
    run() :-
        _ = readLine().

end implement main

goal
    console::run(main::run).
