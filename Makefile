all: main

main.o:  /home/brandon/Documents/GitHub/BGomez-_computer_architecture_1_2023/Proyectox86/main.asm
	nasm -f elf64 /home/brandon/Documents/GitHub/BGomez-_computer_architecture_1_2023/Proyectox86/main.asm
main: /home/brandon/Documents/GitHub/BGomez-_computer_architecture_1_2023/Proyectox86/main.o
	ld -s -o main /home/brandon/Documents/GitHub/BGomez-_computer_architecture_1_2023/Proyectox86/main.o

run:
	./Proyectox86/main

	python /home/brandon/Documents/GitHub/BGomez-_computer_architecture_1_2023/ProyectoPython/lector.py

clean:
	rm -rf __pycache__
