#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

static int test_init(void) {
	printk("<1> I fucking hate linux\n");
	return 0;
}

static void test_exit(void) {
	printk("<1> No, really. I fucking hate it. \n");
}

module_init(test_init);
module_exit(test_exit);

MODULE_LICENSE("Dual BSD/GPL");