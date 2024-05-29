#--------------------------------------Makefile-------------------------------------
include .env
OBJECT = ./build/background1.o ./build/background2.o ./build/game.o ./build/delay.o ./build/goomba.o ./build/obstacle.o ./build/marioImg.o ./build/defaultMario.o ./build/mariojump.o ./build/mariofw.o ./build/terrian1.o ./build/terrian2.o ./build/terrian3.o ./build/terrian10.o ./build/terrian11.o  ./build/hitbox.o ./build/framebf.o ./build/image.o ./build/font.o ./build/mario.o ./build/ground.o ./build/mbox.o ./build/utils.o ./build/kernel.o ./build/defaultGoomba.o
CFILES = $(wildcard ./kernel/*.c)
OFILES = $(CFILES:./kernel/%.c=./build/%.o)
GCCFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib

all:  clean uart1_build timer_build irq_build font_build frame_build uart1_build game_build video_build background_build delay_build image_build mailbox_build utils_build kernel8.img run1
uart1: clean uart1_build kernel8.img run1
uart0: clean uart0_build kernel8.img run0
#./build/uart.o: ./uart/uart1.c
#	aarch64-none-elf-gcc $(GCCFLAGS) -c ./uart/uart1.c -o ./build/uart.o

timer_build: ./timer/sys_timer.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./timer/sys_timer.c -o ./build/sys_timer.o

irq_build: ./irq/irq.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./irq/irq.c -o ./build/irq.o

video_build: ./video/video.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./video/video.c -o ./build/video.o

uart1_build: ./kernel/uart/uart1.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/uart/uart1.c -o ./build/uart.o

uart0_build: ./kernel/uart/uart0.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/uart/uart0.c -o ./build/uart.o

background_build: ./kernel/background/background1.c ./kernel/background/background2.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/background/background1.c -o ./build/background1.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/background/background2.c -o ./build/background2.o

delay_build: ./kernel/delay/delay.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/delay/delay.c -o ./build/delay.o

frame_build: ./kernel/framebuffer/framebf.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/framebuffer/framebf.c -o ./build/framebf.o

image_build: ./kernel/image/image.c ./kernel/image/marioImg.c ./kernel/image/defaultMario.c ./kernel/image/mariofw.c ./kernel/image/mariojump.c ./kernel/image/terrian1.c  ./kernel/image/terrian2.c ./kernel/image/terrian3.c ./kernel/image/terrian10.c ./kernel/image/terrian11.c ./kernel/image/defaultGoomba.c 
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/image/image.c -o ./build/image.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/image/marioImg.c -o ./build/marioImg.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/image/defaultMario.c -o ./build/defaultMario.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/image/mariofw.c -o ./build/mariofw.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/image/mariojump.c -o ./build/mariojump.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/image/terrian1.c -o ./build/terrian1.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/image/terrian2.c -o ./build/terrian2.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/image/terrian3.c -o ./build/terrian3.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/image/defaultGoomba.c  -o ./build/defaultGoomba.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/image/terrian10.c -o ./build/terrian10.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/image/terrian11.c -o ./build/terrian11.o

mailbox_build: ./kernel/mailbox/mbox.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/mailbox/mbox.c -o ./build/mbox.o

utils_build: ./kernel/utils/utils.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/utils/utils.c -o ./build/utils.o

font_build: ./kernel/font/font.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/font/font.c -o ./build/font.o

game_build: ./kernel/game/game.c ./kernel/game/ground.c ./kernel/game/hitbox.c ./kernel/game/mario.c ./kernel/game/obstacle.c ./kernel/game/goomba.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/game/game.c -o ./build/game.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/game/ground.c -o ./build/ground.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/game/hitbox.c -o ./build/hitbox.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/game/mario.c -o ./build/mario.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/game/obstacle.c -o ./build/obstacle.o
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/game/goomba.c -o ./build/goomba.o


./build/boot.o: ./kernel/boot.S
	aarch64-none-elf-gcc $(GCCFLAGS) -c ./kernel/boot.S -o ./build/boot.o

./build/%.o: ./kernel/%.c
	aarch64-none-elf-gcc $(GCCFLAGS) -c $< -o $@

kernel8.img: ./build/boot.o ./build/uart.o ./build/video.o ./build/irq.o ./build/sys_timer.o  $(OBJECT)
	aarch64-none-elf-ld -nostdlib ./build/boot.o ./build/uart.o ./build/video.o ./build/irq.o ./build/sys_timer.o $(OBJECT) -T ./kernel/link.ld -o ./build/kernel8.elf
	aarch64-none-elf-objcopy -O binary ./build/kernel8.elf kernel8.img

clean:
	$(remove_command) $(force) .\build\kernel8.elf .\build\*.o *.img

# Run emulation with QEMU
run1: 
	qemu-system-aarch64 -M $(rasp_window) -kernel kernel8.img -serial null -serial stdio

run0: 
	qemu-system-aarch64 -M $(rasp_window) -kernel kernel8.img -serial stdio
