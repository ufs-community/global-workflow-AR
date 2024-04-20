#! /usr/bin/env bash

# shellcheck disable=SC2155,SC2312
HOMEgfs=$(cd "$(dirname "$(readlink -f -n "${BASH_SOURCE[0]}" )" )/.." && pwd -P)
declare -rx HOMEgfs

## patch config.base
sed -i -e 's#export BASE_CPLIC=.*#export BASE_CPLIC="/scratch2/BMC/wrfruc/Guoqing.Ge/ufs-ar/ICS/global-nest"#' -e 's/export DO_NEST="NO"/export DO_NEST="YES"/' $HOMEgfs/parm/config/gfs/config.base

## patch build_ufs
sed -i -e 's/FV3_GFS_v17_coupled_p8_ugwpv1"/FV3_GFS_v17_coupled_p8_ugwpv1,FV3_global_nest_v1"/' -e 's/^#MAKE_OPT+=/MAKE_OPT+=/' $HOMEgfs/sorc/build_ufs.sh

## patch link_workflow.sh
sed -i -e 's#"hera").*#"hera")   FIX_DIR="/scratch2/BMC/wrfruc/Guoqing.Ge/fix" ;;#' -e 's#versions/fix.ver#versions/fix.nest.ver#' $HOMEgfs/sorc/link_workflow.sh
