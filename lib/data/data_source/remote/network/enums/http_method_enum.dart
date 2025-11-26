enum HttpMethodEnum {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  const HttpMethodEnum(this.value);

  final String value;
}
