{ secrets }:

{
  net = {
    domain = secrets.net.domain;
    
    # hosts
    t480 = {
      hostname = "t480";
    };
  };
}
