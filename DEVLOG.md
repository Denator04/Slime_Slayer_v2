Dziennik zmian:

25.10 - dodanie tymczasowych sprite-ów, zmiana koloru tła, dodanie hit-boxu, próba zaimplementowania poruszania gracza nieudana - spróbuje coś z tym  podziałać później ŁH

27.10 - postać porusza się pod wsad, sprite-y zmieniają się w zależności czy postać stoi w miejscu, czy się porusza, przy przytrzymaniu shift postać porusza się szybciej (taki ala sprint), dodanie przewrotu przy naciśnięciu spacji, którego prędkość zależy czy w danym momencie sprintujemy, dodanie tekstur drzewa i trawy - utworzenie platformy testowej przy użyciu Tilesetów

29.10 - 1.11 - stworzenie kilku tekstur m.in tabliczki, stworzenie tła do menu głównego i sprite'a głównej postaci oraz podstawowego przeciwnika - slime'a - odkryłem nowy talent do pixel artów xd ŁH

3.11 - zmienilem ta linijke 		
		if !is_flipping and character_direction != Vector2.ZERO:
			sprite.play("rycerz_walk") - teraz animacja biegania sie loopuje a nie zatrzymuje po 1 razie
			

13.11 - nowa postac, chodzenie dziala tak jak nalezy, dodal bym tez teraz atak ale idziemy do marcina XD
