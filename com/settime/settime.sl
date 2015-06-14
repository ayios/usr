loadfrom ("time", "checktmfmt", NULL, &on_eval_err);
loadfrom ("proc", "procInit", NULL, &on_eval_err);

variable
  date = which ("date"),
  hwclock = which ("hwclock");

define gethwclock ()
{
  variable
    status;
  
  variable p = proc->init (0, 1, 0);

  status = p.execv ([hwclock, "-r"], NULL);
  
  tostdout ("Hardware time: " + strtrim_end (p.stdout.out));

  return status;
}

define sethwclock ()
{
  variable
    
    status;
  
  variable p = proc->init (0, 0, 0);

  status = p.execv ([hwclock, "--systohc"], NULL);

  return status;
}

define main ()
{
  variable
    status,
    tim = NULL,
    c = cmdopt_new (&_usage);

  c.add ("tf", &tim;type = "string");
  c.add ("v|verbose", &verboseon);
  c.add ("info", &info);
  c.add ("help", &_usage);
  
  () = c.process (__argv, 1);

  if (NULL == tim)
    {
    tostderr ("--tf= argument is required");
    exit_me (1);
    }

  variable tok = strchop (tim, ':', 0);

  ifnot (6 == length (tok))
    {
    tostderr ("time format is wrong, it should be SS:MM:HH:DD:MM:YY");
    exit_me (1);
    }

  tok = array_map (Integer_Type, &atoi, tok);
  
  tim = localtime (_time);

  set_struct_fields (tim, tok[0], tok[1], tok[2], tok[3], tok[4], tok[5]);

  variable retval = checktmfmt (tim);

  if (NULL == retval)
    {
    variable err = ();
    tostderr (err);
    exit_me (1);
    }

  variable tf = strjoin (array_map (String_Type, &sprintf, "%.2d",
    [tim.tm_mon, tim.tm_mday, tim.tm_hour, tim.tm_min,
    tim.tm_year]));
  
  if (NULL == hwclock)
    tostderr ("hwclock hasn't been found in PATH, cannot set hardware clock");
  
  if (NULL == date)
    {
    tostderr ("date hasn't been found in PATH, cannot set system time");
    exit_me (1);
    }

  ifnot (NULL == hwclock)
    {
    status = gethwclock ();

    if (status.exit_status)
      exit_me (status.exit_status);
    }

  variable p = proc->init (0, 1, 0);

  status = p.execv ([date, tf], NULL);
  
  tostdout ("Set Time to: " + strtrim_end (p.stdout.out));

  if (status.exit_status)
    exit_me (status.exit_status);
  
  ifnot (NULL == hwclock)
    {
    status = sethwclock ();

    if (status.exit_status)
      exit_me (status.exit_status);
    }

  sleep (1);

  ifnot (NULL == hwclock)
    {
    status = gethwclock ();

    if (status.exit_status)
      exit_me (status.exit_status);
    }
  
  exit_me (0);
}
