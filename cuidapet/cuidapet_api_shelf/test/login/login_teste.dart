import 'package:cuidapet_api/utils/jwt_utils.dart';

import '../harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("Check login inválido", () async {
    // var a = await harness.agent.post("/login");
    expectResponse(await harness.agent.post("/login", body: {'email': '', 'senha': ''}), Response.forbidden().statusCode);
  });

  test("Check login válido", () async {
    expectResponse(
      await harness.agent.post("/login", body: {'login': 'rodrigorahman@gmail.com', 'senha': '123'}),
      200,
      body: {"access_token": JwtUtils.generateJWT(1)},
    );
  });

  test("Patch login ios", () async {
    final accessToken = JwtUtils.generateJWT(1);
    expectResponse(
      await harness.agent.execute('patch', "/login/confirm", headers: {
        'Authorization': accessToken
      }, body: {
        'ios_token': 'IOSTOKEN',
      }),
      200,
      body: {"access_token": accessToken, 'refresh_token': JwtUtils.refreshToken(accessToken)},
    );
  });

  test("Patch login Android", () async {
    final accessToken = JwtUtils.generateJWT(1);
    expectResponse(
      await harness.agent.execute('patch', "/login/confirm", headers: {
        'Authorization': accessToken
      }, body: {
        'access_token': accessToken,
        'android_token': 'ANDROIDTOKEN',
      }),
      200,
      body: {"access_token": accessToken, 'refresh_token': JwtUtils.refreshToken(accessToken)},
    );
  });
}
