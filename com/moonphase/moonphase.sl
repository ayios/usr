loadfrom ("time", "julian_day_nr", NULL, &on_eval_err);
loadfrom ("time", "isleap", NULL, &on_eval_err);
loadfrom ("time", "week_day", NULL, &on_eval_err);
loadfrom ("time", "julian_day_to_cal", NULL, &on_eval_err);
loadfrom ("time", "moon_phase", NULL, &on_eval_err);
loadfrom ("string", "repeat", NULL, &on_eval_err);
loadfrom ("time", "checktmfmt", NULL, &on_eval_err);
loadfrom ("string", "strtoint", NULL, &on_eval_err);

verboseon ();

define increase_tf (tim)
{
  variable
    year = (@tim).tm_year,
    months = [31, 28 + isleap (year), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
    day = (@tim).tm_mday,
    mon = ((@tim).tm_mon);

  if (day == months[mon])
    {
    (@tim).tm_mday = 1;
    (@tim).tm_mon++;
    if (12 == (@tim).tm_mon)
      {
      (@tim).tm_year++;
      (@tim).tm_mon = 0;
      }
    }
  else
    (@tim).tm_mday++;

}

define main ()
{
  variable
    err,
    mp,
    tok,
    retval,
    tim = NULL,
    repeats = NULL,
    c = cmdopt_new (&_usage);

  c.add ("tf", &tim;type = "string");
  c.add ("for", &repeats;type = "int");
  c.add ("info", &info);
  c.add ("help", &_usage);    

  () = c.process (__argv, 1);
 
  if (NULL == tim)
    {
    tim = localtime (_time);
    tim.tm_year+= 1900;
    }
  else
   {
   tok = strchop (tim, ':', 0);
   tim = localtime (_time);
  
   ifnot (6 == length (tok))
     {
     tostderr ("wrong time format");
     exit_me (1);
     }
  
   tok = array_map (Integer_Type, &atoi, tok);
   set_struct_fields (tim, tok[0], tok[1], tok[2], tok[3], tok[4] - 1, tok[5]);
  
   retval = checktmfmt (tim);
   
   if (NULL == retval)
      {
      err = ();
      tostderr (err);
      exit_me (1);
      }
   }
 
  if (NULL != repeats)
    {
    mp = moon_phase (tim);
 
    if (NULL == mp)
      {
      err = ();
      tostderr (err);
      exit_me (1);
      }

    mp = [mp];

    loop (repeats)
      {
      increase_tf (&tim);

      mp = [mp, repeat ("_", COLUMNS), moon_phase (tim)];
      }
    }
  else
    {
    mp = moon_phase (tim);
 
    if (NULL == mp)
      {
      err = ();
      tostderr (err);
      exit_me (1);
      }
    }
 
  array_map (Void_Type, &tostdout, mp);
  exit_me (0);
}
