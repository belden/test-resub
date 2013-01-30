package dm;

BEGIN {
  *CORE::GLOBAL::fork = \&CORE::fork;
  *CORE::GLOBAL::print = \&CORE::print;
  *CORE::GLOBAL::time = \&CORE::time;
  *CORE::GLOBAL::open = \&CORE::open;
}

1;
