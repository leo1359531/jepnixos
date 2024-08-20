{pkgs, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      StartTree = {
        image = "nginx";
        ports = [
          "127.0.0.1:8080:80"
        ];
        volumes = [
          "/home/leo/.cache/StartTree/styles/colors.css:/usr/share/nginx/html/styles/colors.css" # This needs to be changed depending on theme
          "/home/leo/.cache/StartTree/index.html:/usr/share/nginx/html/index.html"
          "/home/leo/.cache/StartTree/styles/style.css:/usr/share/nginx/html/styles/style.css"
          "/home/leo/.cache/StartTree/styles/Hack.ttf:/usr/share/nginx/html/styles/Hack.ttf"
          "/home/leo/.cache/StartTree/default.conf:/etc/nginx/conf.d/default.conf" # "modified" conf to disable page caching :)
        ];
      };
    };
  };
}
