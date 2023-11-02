<?php
class Controller
{
	var $db;

	function __construct()
	{
		global $db;
		$this->db = $db;
	}

	public function getMsgException($e)
	{
		$return_data = array();
		$return_data['error'] = $e->getCode();
		$return_data['msg'] = $e->getMessage();
		return $return_data;
	}

	public function getMonthArray($date)
	{
		$start_date = date("Y-m" . "-01", strtotime($date));
		$start_time = strtotime($start_date);

		$end_time = strtotime("+1 month", $start_time);

		for ($i = $start_time; $i < $end_time; $i += 86400) {
			$list[]['date'] = date('Y-m-d', $i);
		}

		return $list;
	}

	public function getImageLink($query)
	{
		$api_server = 'https://dapi.kakao.com/v3/search/book';
		$headers = array('Authorization: KakaoAK 8345a745fde6d810b517358645355050 ');
		$opts = array(
			CURLOPT_URL => $api_server . '?' . $query,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_SSL_VERIFYPEER => false,
			CURLOPT_SSLVERSION => 1,
			CURLOPT_HEADER => false,
			CURLOPT_HTTPHEADER => $headers
		);
		$curl_session = curl_init();
		curl_setopt_array($curl_session, $opts);
		$return_data = curl_exec($curl_session);
		if (curl_errno($curl_session)) {
			throw new Exception(curl_error($curl_session));
		} else {
			curl_close($curl_session);
			return $return_data;
		}
	}
}