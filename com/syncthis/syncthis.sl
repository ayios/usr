load.from ("sync", "sync", 1;err_handler = &__err_handler__);

File->Fun ("are_same__", NULL);

verboseon ();

define main ()
{
  variable
    exit_code = 0,
    cur = Dir->Vget ("SOURCEDIR"),
    tree = NULL,
    interactive_copy = 0,
    ignoreverbosity = 0,
    ignoreonremoveverbosity = 0,
    c = cmdopt_new (&_usage);

  c.add ("from", &tree;type = "string");
  c.add ("verboseoff", &verboseoff);
  c.add ("copyinteractive", &interactive_copy;type = "int");
  c.add ("ign_verbose", &ignoreverbosity;type = "int");
  c.add ("ign_rm_verbose", &ignoreonremoveverbosity;type = "int");
  c.add ("help", &_usage);
  c.add ("info", &info);

  () = c.process (__argv, 1);

  if (NULL == tree)
    {
    IO.tostderr ("source tree hasn't been specified");
    exit_me (1);
    }

  variable sync = sync->sync_new ();

  sync.interactive_remove = 1;
  sync.ignoredir = IO.readfile (Dir->Vget ("LCLDATADIR") + "/excludedirs.txt");
  sync.ignoredironremove = sync.ignoredir;
  sync.ignorefile = IO.readfile (Dir->Vget ("LCLDATADIR") + "/excludefiles.txt");
  sync.ignorefileonremove = sync.ignorefile;
  sync.ignoreverbosity = ignoreverbosity;
  sync.ignoreonremoveverbosity = ignoreonremoveverbosity;
  sync.interactive_copy = interactive_copy;

  if (File.are_same (cur, tree))
    {
    IO.tostderr ("you are trying to sync with me");
    exit_me (1);
    }

  tree = strtrim_end (tree, "/");

  exit_code = sync.run (tree, cur);

  if (exit_code)
    IO.tostderr (sprintf ("sync failed, EXIT_CODE: %d", exit_code));

  exit_me (exit_code);
}
