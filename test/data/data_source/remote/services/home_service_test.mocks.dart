
import 'dart:async' as _i5;

import 'package:bevlioon/data/data_source/remote/network/api_client.dart'
    as _i4;
import 'package:bevlioon/data/data_source/remote/network/models/endpoint.dart'
    as _i6;
import 'package:bevlioon/data/data_source/remote/network/models/network_response.dart'
    as _i3;
import 'package:bevlioon/data/data_source/remote/network/network_info/network_info.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;


class _FakeNetworkInfo_0 extends _i1.SmartFake implements _i2.NetworkInfo {
  _FakeNetworkInfo_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNetworkResponse_1<T1> extends _i1.SmartFake
    implements _i3.NetworkResponse<T1> {
  _FakeNetworkResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class MockApiClient extends _i1.Mock implements _i4.ApiClient {
  MockApiClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.NetworkInfo get networkInfo => (super.noSuchMethod(
        Invocation.getter(#networkInfo),
        returnValue: _FakeNetworkInfo_0(
          this,
          Invocation.getter(#networkInfo),
        ),
      ) as _i2.NetworkInfo);

  @override
  _i5.Future<_i3.NetworkResponse<T>> get<T>(
    _i6.Endpoint? endpoint, {
    T Function(Map<String, dynamic>)? onMap,
    T Function(List<Map<String, dynamic>>)? onList,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [endpoint],
          {
            #onMap: onMap,
            #onList: onList,
          },
        ),
        returnValue:
            _i5.Future<_i3.NetworkResponse<T>>.value(_FakeNetworkResponse_1<T>(
          this,
          Invocation.method(
            #get,
            [endpoint],
            {
              #onMap: onMap,
              #onList: onList,
            },
          ),
        )),
      ) as _i5.Future<_i3.NetworkResponse<T>>);

  @override
  _i5.Future<_i3.NetworkResponse<T>> post<T>(
    _i6.Endpoint? endpoint, {
    T Function(Map<String, dynamic>)? onMap,
    T Function(List<Map<String, dynamic>>)? onList,
    bool? isDriverIdRequired = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [endpoint],
          {
            #onMap: onMap,
            #onList: onList,
            #isDriverIdRequired: isDriverIdRequired,
          },
        ),
        returnValue:
            _i5.Future<_i3.NetworkResponse<T>>.value(_FakeNetworkResponse_1<T>(
          this,
          Invocation.method(
            #post,
            [endpoint],
            {
              #onMap: onMap,
              #onList: onList,
              #isDriverIdRequired: isDriverIdRequired,
            },
          ),
        )),
      ) as _i5.Future<_i3.NetworkResponse<T>>);

  @override
  _i5.Future<_i3.NetworkResponse<T>> put<T>(
    _i6.Endpoint? endpoint, {
    T Function(Map<String, dynamic>)? onMap,
    T Function(List<Map<String, dynamic>>)? onList,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [endpoint],
          {
            #onMap: onMap,
            #onList: onList,
          },
        ),
        returnValue:
            _i5.Future<_i3.NetworkResponse<T>>.value(_FakeNetworkResponse_1<T>(
          this,
          Invocation.method(
            #put,
            [endpoint],
            {
              #onMap: onMap,
              #onList: onList,
            },
          ),
        )),
      ) as _i5.Future<_i3.NetworkResponse<T>>);

  @override
  _i5.Future<_i3.NetworkResponse<T>> delete<T>(
    _i6.Endpoint? endpoint, {
    T Function(Map<String, dynamic>)? onMap,
    T Function(List<Map<String, dynamic>>)? onList,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [endpoint],
          {
            #onMap: onMap,
            #onList: onList,
          },
        ),
        returnValue:
            _i5.Future<_i3.NetworkResponse<T>>.value(_FakeNetworkResponse_1<T>(
          this,
          Invocation.method(
            #delete,
            [endpoint],
            {
              #onMap: onMap,
              #onList: onList,
            },
          ),
        )),
      ) as _i5.Future<_i3.NetworkResponse<T>>);
}

