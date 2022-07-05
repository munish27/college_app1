enum STATUS { INITIAL, LOADING, SUCCESS, ERROR }

class ApiResponse<T> {
  STATUS status;
  String? errMsg;
  T? data;
  int? statusCode;

  ApiResponse.success(this.data) : status = STATUS.SUCCESS;
  ApiResponse.error(this.errMsg, this.statusCode) : status = STATUS.ERROR;
}
