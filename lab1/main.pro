% Copyright

   %product(Id, Name, type)
    product(1, "Cheese", "food").
    product(2, "Meet", "food").
    product(3, "Bread", "food").
    product(4, "Milk", "beverages").
    product(5, "Tea", "beverages").


    %client(Id, Name)
    client(1, "Kirill").
    client(2, "Nikita").
    client(3, "Andrey").
    client(4, "Aleksandra").
    client(5, "Alina").

    %purchase(ClientId, ProductId, Cost)
    purchase(3, 1, 100).
    purchase(4, 2, 150).
    purchase(2, 3, 400).
    purchase(1, 2, 100).
    purchase(1, 4, 200).
    purchase(4, 1, 250 ).
    purchase(3, 2, 500).
    purchase(5, 5, 300).
    purchase(1, 4, 100).
    purchase(2, 1, 400).


%ПРАВИЛА

    %Первое правило
    %Показываем кто покупал данный товар
    product_buy(X) :-
    	product(Id_prod, X, _),
        purchase(Id_client, Id_prod, _),
        client(Id_client, Name).
    %Второе правило
    %Показываем что и по какой цене покупал клиент
    client_buy(X) :-
        client(Id, X),
        purchase(Id, Id_p, Cost),
        product(Id_p, Name_p, _).

    %Третье правило
    %Показываем тип товара
    product_type(X) :-
        product(_, X, Type).