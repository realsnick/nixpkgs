{ lib
, stdenv
, aiohttp
, async-timeout
, buildPythonPackage
, defusedxml
, fetchFromGitHub
, pytest-asyncio
, pytestCheckHook
, python-didl-lite
, pythonOlder
, voluptuous
}:

buildPythonPackage rec {
  pname = "async-upnp-client";
  version = "0.19.2";
  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "StevenLooman";
    repo = "async_upnp_client";
    rev = version;
    sha256 = "1v8d2lvxihqasn7866zssys16s0lgxkk6ri2dp4rr7wr8g9ixvdr";
  };

  propagatedBuildInputs = [
    aiohttp
    async-timeout
    defusedxml
    python-didl-lite
    voluptuous
  ];

  checkInputs = [
    pytestCheckHook
    pytest-asyncio
  ];

  disabledTests = [
    # socket.gaierror: [Errno -2] Name or service not known
    "test_get_local_ip"
    "test_async_get_local_ip"
    # OSError: [Errno 101] Network is unreachable
    "test_subscribe_fail"
    "test_subscribe_auto_resubscribe"
    "test_subscribe_manual_resubscribe"
    "test_auto_resubscribe_fail"
    "test_on_notify_dlna_event"
    "test_on_notify_upnp_event"
    "test_unsubscribe"
    "test_subscribe"
    "test_subscribe_renew"
    "test_start_server"
    "test_init"
  ] ++ lib.optionals stdenv.isDarwin [
    "test_deferred_callback_url"
  ];

  pythonImportsCheck = [ "async_upnp_client" ];

  meta = with lib; {
    description = "Asyncio UPnP Client library for Python";
    homepage = "https://github.com/StevenLooman/async_upnp_client";
    license = licenses.asl20;
    maintainers = with maintainers; [ hexa ];
  };
}
