#!/bin/bash
#
# This is a positional arguments-only example of Argbash potential
#
# ARG_HELP([This script uploads an Android apk or iOS ipa to Sauce Labs given the User Name and Access Key passed])
# ARG_POSITIONAL_SINGLE([sl_user_name],[Sauce Labs User Name])
# ARG_POSITIONAL_SINGLE([sl_access_key],[Sauce Labs Access Key])
# ARG_POSITIONAL_SINGLE([app_location],[Name and Location of the App apk or iOS ipa])
# ARG_POSITIONAL_SINGLE([app_description],[Description of the app])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.9.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info
# Generated online by https://argbash.io/generate


die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


begins_with_short_option()
{
	local first_option all_short_options='h'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
# THE DEFAULTS INITIALIZATION - OPTIONALS


print_help()
{
	printf '%s\n' "This script uploads an Android apk or iOS ipa to Sauce Labs given the User Name and Access Key passed"
	printf 'Usage: %s [-h|--help] <sl_user_name> <sl_access_key> <app_location> <app_description>\n' "$0"
	printf '\t%s\n' "<sl_user_name>: Sauce Labs User Name"
	printf '\t%s\n' "<sl_access_key>: Sauce Labs Access Key"
	printf '\t%s\n' "<app_location>: Name and Location of the App apk or iOS ipa"
	printf '\t%s\n' "<app_description>: Description of the app"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	_positionals_count=0
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			*)
				_last_positional="$1"
				_positionals+=("$_last_positional")
				_positionals_count=$((_positionals_count + 1))
				;;
		esac
		shift
	done
}


handle_passed_args_count()
{
	local _required_args_string="'sl_user_name', 'sl_access_key', 'app_location' and 'app_description'"
	test "${_positionals_count}" -ge 4 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require exactly 4 (namely: $_required_args_string), but got only ${_positionals_count}." 1
	test "${_positionals_count}" -le 4 || _PRINT_HELP=yes die "FATAL ERROR: There were spurious positional arguments --- we expect exactly 4 (namely: $_required_args_string), but got ${_positionals_count} (the last one was: '${_last_positional}')." 1
}


assign_positional_args()
{
	local _positional_name _shift_for=$1
	_positional_names="_arg_sl_user_name _arg_sl_access_key _arg_app_location _arg_app_description "

	shift "$_shift_for"
	for _positional_name in ${_positional_names}
	do
		test $# -gt 0 || break
		eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
		shift
	done
}

parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash


echo "Value of first argument: $_arg_sl_user_name"
echo "Value of second argument: $_arg_sl_access_key"
echo "Value of third argument: $_arg_app_location"
echo "Value of third argument: $_arg_app_description"


echo "------------------UPLOADING-APP-TO-SAUCE-LABS------------------"
curl -u "$_arg_sl_user_name:$_arg_sl_access_key" --location \
--request POST 'https://api.us-west-1.saucelabs.com/v1/storage/upload' \
--form 'payload=@"$_arg_app_location"' \
--form 'name="$(basename $_arg_app_location)"' \
--form 'description="$_arg_app_description"'

curl -u "$SAUCE_USERNAME:$SAUCE_ACCESS_KEY" --location \
--request POST 'https://api.us-west-1.saucelabs.com/v1/storage/upload' \
--form 'payload=@"g16K4P8IX/iOS.RealDevice.SauceLabs.Mobile.Sample.app.2.7.1.ipa"' \
--form 'name="iOS.RealDevice.SauceLabs.Mobile.Sample.app.2.7.1.ipa"' \
--form 'description="iOS Test App v3"'

# May need this data in the tests somewhere. 
#  {
#     "item": {
#         "id": "7a154f05-835f-469a-93cf-880647d3a8ab",
#         "owner": {
#             "id": "******",
#             "org_id": "******"
#         },
#         "name": "iOS.RealDevice.SauceLabs.Mobile.Sample.app.2.7.1.ipa",
#         "upload_timestamp": 1619035533,
#         "etag": "184d1c399251e8849edcb0adfc079571",
#         "kind": "ios",
#         "group_id": 64612,
#         "description": null,
#         "metadata": {
#             "identifier": "com.saucelabs.SwagLabsMobileApp",
#             "name": "SwagLabsMobileApp",
#             "version": "12",
#             "is_test_runner": false,
#             "icon": "...",
#             "short_version": "2.7.1",
#             "is_simulator": false,
#             "min_os": "10.0",
#             "target_os": "14.2",
#             "test_runner_plugin_path": null
#         },
#         "access": {...}
#     }
# }
# may need to write the app info to the config file?

# ] <-- needed because of Argbash