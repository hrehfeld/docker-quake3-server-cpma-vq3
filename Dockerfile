FROM archlinux:base-devel AS builder


RUN pacman -Sy --needed base-devel git sdl2-compat unzip --noconfirm

# for some reason git clone to git://github.com in makepkg is failing so rewrite to http
RUN env EUID=1 git config --global url."https://".insteadOf git://

ADD https://aur.archlinux.org/libxxf86dga.git#master /libxxf86dga
RUN cd /libxxf86dga && env EUID=1 makepkg -fsri --noconfirm

ADD https://aur.archlinux.org/quake3e-git.git#master /quake3e
# patch so we don't build client
# && sed -i -e 's/^\s*make\s*$/make BUILD_CLIENT=0/' PKGBUILD
RUN cd /quake3e && env EUID=1 makepkg -fsri --noconfirm

ADD https://aur.archlinux.org/quake3-cpma.git#master /quake3-cpma
RUN cd /quake3-cpma && env EUID=1 makepkg -fsri --noconfirm


#hub3aeroq3 hub3dm1 nodm9 nodm10

# ADD --link https://ws.q3df.org/maps/downloads/pro-nodm9.pk3 /opt/quake3/
# ADD --link https://ws.q3df.org/maps/downloads/map_nodm9.pk3 /opt/quake3/
# ADD --link https://ws.q3df.org/maps/downloads/nodm10.pk3 /opt/quake3/
# ADD --link https://ws.q3df.org/maps/downloads/nodm13.pk3 /opt/quake3/
# ADD --link https://ws.q3df.org/maps/downloads/hub3aeroq3.pk3 /opt/quake3/
# ADD --link https://ws.q3df.org/maps/downloads/hub3aeroq3a.pk3 /opt/quake3/
# ADD --link https://ws.q3df.org/maps/downloads/hub3tourney1.pk3 /opt/quake3/
# ADD --link --checksum=sha256:c8a2d186a286e9d95f87066e438a4e5247eaa5810879ca7b2fab2d2a44a55364 https://ws.q3df.org/maps/downloads/ztn3tourney1.pk3 /opt/quake3/
# # ADD --link https://ws.q3df.org/maps/downloads/charonq2dm1v2.pk3 /opt/quake3/
# ADD --link https://archive.org/download/edge_20240120/OtherGames/Quake3/charonq2dm1v2.zip /maps
# #ADD --link https://ws.q3df.org/maps/downloads/q3shw26.pk3 /opt/quake3/

# #ADD --link https://ws.q3df.org/maps/downloads/sin.pk3 /opt/quake3/
# #ADD --link https://ws.q3df.org/maps/downloads/szq2dm1ish.pk3 /opt/quake3/

# # ADD --link https://ws.q3df.org/maps/downloads/hub3dm1.pk3 /opt/quake3/
# # ADD --link https://ws.q3df.org/maps/downloads/hub3dm1.pk3 /opt/quake3/



#hub3aeroq3 hub3dm1 nodm9 nodm10
RUN pacman -S --needed unzip curl --noconfirm
ADD --link https://files.ioquake3.org/quake3-latest-pk3s.zip /maps/
#ADD --link https://files.lvlworld.com/get.php/m-r/q3shw26/3b24a478340d5cbb0bbc5ddc916d1666 /opt/quake3/
# ADD --link  https://lvlworld.fast-stable-secure.net/s-z/ztn3tourney1.zip /maps/
# ADD --link https://lvlworld.fast-stable-secure.net/g-l/hub3aeroq3.zip /maps/
# ADD --link https://lvlworld.fast-stable-secure.net/g-l/hub3dm1.zip /maps/
# ADD --link https://lvlworld.fast-stable-secure.net/m-r/nodm9.zip  /maps/
# ADD --link https://lvlworld.fast-stable-secure.net/m-r/nodm10.zip /maps
# ADD --link https://lvlworld.fast-stable-secure.net/a-f/charonq2dm1v2.zip /maps
# ADD --link https://lvlworld.fast-stable-secure.net/s-z/sin.zip /maps
# ADD --link https://lvlworld.fast-stable-secure.net/s-z/szq2dm1ish.zip /maps
# ADD --link https://lvlworld.fast-stable-secure.net/m-r/q3shw26.zip /maps
# ADD --link https://lvlworld.fast-stable-secure.net/
# ADD --link https://lvlworld.fast-stable-secure.net/
# ADD --link https://lvlworld.fast-stable-secure.net/
# ADD --link https://lvlworld.fast-stable-secure.net/




# RUN curl --output-dir /maps/ -O "https://web.archive.org/web/20051216115451if_/http://megaman.fragland.net:80/dls/megadm6.zip"
# RUN curl --output-dir /maps/ -O "https://web.archive.org/web/20050903014518/http://megaman.fragland.net/dls/megadm3.zip"


RUN cd /maps && unzip *.zip && cp quake3-latest-pk3s/baseq3/*.pk3 /opt/quake3/baseq3/

FROM archlinux

COPY --from=builder /opt/quake3 /opt/quake3

# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

WORKDIR /opt/quake3
WORKDIR /root

CMD ["/entrypoint.sh"]
