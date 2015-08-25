loadfrom ("sync", "sync", 1, &on_eval_err);
loadfrom ("dir", "are_same_files", NULL, &on_eval_err);

verboseon ();

define main ()
{
  variable
    exit_code = 0,
    cur = SOURCEDIR,
    tree = NULL,
    ignoreverbosity = 0,
    ignoreonremoveverbosity = 0,
    c = cmdopt_new (&_usage);
 
  c.add ("to", &tree;type = "string");
  c.add ("verboseoff", &verboseoff);
  c.add ("ign_verbose", &ignoreverbosity);
  c.add ("ign_rm_verbose", &ignoreonremoveverbosity);
  c.add ("help", &_usage);
 
  () = c.process (__argv, 1);

  if (NULL == tree)
    {
    tostderr ("source tree hasn't been specified");
    exit_me (1);
    }

  variable sync = sync->sync_new ();
 
  sync.interactive_remove = 1;
  sync.ignoredir = readfile (LCLDATADIR + "/excludedirs.txt");
  sync.ignoredironremove = sync.ignoredir;
  sync.ignorefile = readfile (LCLDATADIR + "/excludefiles.txt");
  sync.ignorefileonremove = sync.ignorefile;
  sync.ignoreverbosity = ignoreverbosity;
  sync.ignoreonremoveverbosity = ignoreonremoveverbosity;

  if (are_same_files (cur, tree))
    {
    tostderr ("you are trying to sync with me");
    exit_me (1);
    }

  tree = strtrim_end (tree, "/");
 
  exit_code = sync.run (cur, tree);

  if (exit_code)
    tostderr (sprintf ("sync failed, EXIT_CODE: %d", exit_code));
 
  exit_me (exit_code);
}
