Opis działania algorytmu (PL).

1. Inwestor otwiera pozycję długą lub krótką ręcznie.

	Inwestor składa zlecenie po cenie rynkowej (Market order), dla którego nie określa
	poziomu cięcia strat i akceptacji zysku. Tak złożone zlecenie ma następujące parametry:

		* typ zlecenia (Market order OP_BUY lub OP_SELL),
		* stop loss = 0.00000,
		* take profit = 0.0000,
		* magic number = 0

	Algorytm w kazdym ticku przeszukuje kolejkę otwartych zlecen w poszukiwaniu
	zleceń o powyższych parametrach. Jezeli takie zlecenie znajdzie składa zlecenie
	modyfikujace zlecenie glowne (używając do tego numeru zleenia Ticket) ustawiająć
	cenę take profit.
	 

2. Inwestor otwiera pozycję długą lub krótką używając do tego innego algorytmu.
	
	Algorytm funkcjonuje identycznie jak w poprzednim przypadku. Trzeba tylko zwrócić 
	uwagę na to, aby odpowiednie wartości w algorytmie otwierającym pozycje (magic number,
	tekeProfit i stopLoss miały wartości zerowe (domyślne).
	
	Używałem tego algorytmu w takiej konfiguracji. Algorytm otwierajacy pozycję był
	uruchomiony na jednej fizycznej maszynie, a zamykający (25_Pips_profit) na drugiej
	fizycznej maszynie. Oba działaly niezależnie od siebie.


3. Algorytm działa tylko dla dwóch typów zleceń.

	Algorytm obsługuje tylko zlecenia OP_BUY i OP_SELL, czyli zlecenia typu market.


Sosnowiec, 19 sierpnia 2017 r.
