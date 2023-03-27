all:  main 

main.o:  main.asm
	nasm -f elf64 main.asm
main: 	main.o
	ld -s -o main main.o
	./main
run:
	python /home/brandon/Documents/GitHub/BGomez-_computer_architecture_1_2023/ProyectoPython/lector.py

clean:
	rm -f main.o main
