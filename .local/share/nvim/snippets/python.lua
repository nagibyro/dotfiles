return {
	s("punit", {
		t({ "class " }),
		i(1, "TestClass"),
		t("(TestCase):"),
		t({ "", "\tdef " }),
		i(2, "test_example"),
		t("(self):"),
		t({ "", "\t\t" }),
		i(3, "self.assertEqual(1, 1)"),
	}),
}
