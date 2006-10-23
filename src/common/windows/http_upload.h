// Copyright (c) 2006, Google Inc.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//     * Neither the name of Google Inc. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

// HTTPUpload provides a "nice" API to send a multipart HTTP(S) POST
// request using wininet.  It currently supports requests that contain
// a set of string parameters (key/value pairs), and a file to upload.

#ifndef COMMON_WINDOWS_HTTP_UPLOAD_H__
#define COMMON_WINDOWS_HTTP_UPLOAD_H__

#include <string>
#include <map>
#include <vector>
namespace google_airbag {

using std::string;
using std::wstring;
using std::map;
using std::vector;

class HTTPUpload {
 public:
  // Sends the given set of parameters, along with the contents of
  // upload_file, as a multipart POST request to the given URL.
  // file_part_name contains the name of the file part of the request
  // (i.e. it corresponds to the name= attribute on an <input type="file">.
  // Parameter names must contain only printable ASCII characters,
  // and may not contain a quote (") character.
  // Only HTTP(S) URLs are currently supported.  Returns true on success.
  // TODO(bryner): we should expose the response to the caller.
  static bool SendRequest(const wstring &url,
                          const map<wstring, wstring> &parameters,
                          const wstring &upload_file,
                          const wstring &file_part_name);

 private:
  class AutoInternetHandle;

  // Generates a new multipart boundary for a POST request
  static wstring GenerateMultipartBoundary();

  // Generates a HTTP request header for a multipart form submit.
  static wstring GenerateRequestHeader(const wstring &boundary);

  // Given a set of parameters, an upload filename, and a file part name,
  // generates a multipart request body string with these parameters
  // and minidump contents.  Returns true on success.
  static bool GenerateRequestBody(const map<wstring, wstring> &parameters,
                                  const wstring &upload_file,
                                  const wstring &file_part_name,
                                  const wstring &boundary,
                                  string *request_body);

  // Fills the supplied vector with the contents of filename.
  static void GetFileContents(const wstring &filename, vector<char> *contents);

  // Converts a UTF16 string to UTF8.
  static string WideToUTF8(const wstring &wide);

  // Checks that the given list of parameters has only printable
  // ASCII characters in the parameter name, and does not contain
  // any quote (") characters.  Returns true if so.
  static bool CheckParameters(const map<wstring, wstring> &parameters);

  // No instances of this class should be created.
  // Disallow all constructors, destructors, and operator=.
  HTTPUpload();
  explicit HTTPUpload(const HTTPUpload &);
  void operator=(const HTTPUpload &);
  ~HTTPUpload();
};

}  // namespace google_airbag

#endif  // COMMON_WINDOWS_HTTP_UPLOAD_H__