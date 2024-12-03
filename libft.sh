cc -o libft.so -shared -Wl,--whole-archive libft.a -Wl,--no-whole-archive
wget https://github.com/er1t-h/libft_monkey_tester/releases/latest/download/libft_tester
chmod +x libft_tester
LIBFT_TESTER_RANDOM_REPEAT=5000 ./libft_tester
if [ "$?" -eq 0 ]
then
	wget https://raw.githubusercontent.com/er1t-h/libft_monkey_tester/refs/heads/main/valgrind_suppression_files/patch_rusty_and_cargo_test.txt
	valgrind --leak-check=full --show-leak-kinds=all --suppressions=patch_rusty_and_cargo_test.txt --log-file=libft_monkey_tester.log ./libft_tester
	if [ "$?" -eq 0 ]
	then
		cat libft_monkey_tester.log
	else
		echo "You failed the valgrind tests"
	fi
else
	echo "You failed some tests"
fi