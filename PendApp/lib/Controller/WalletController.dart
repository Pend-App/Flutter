import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pend_tech/screen/osama/encryption_model.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class WalletController extends GetxController {
  late Credentials unlocked;
  Dio dio = new Dio();
  var apiUrl = "https://rinkeby.infura.io/v3/39e9e246342b4a4aa21b8a8eacb0bde2"; //Replace with your API
  var httpClient = new Client();
  var myData ;
  var publicKey;

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/Wallet.json'; // 3

    return filePath;
  }

  Future<void> ReadWallet(String passX, BuildContext context) async {
    String content = new File(await getFilePath()).readAsStringSync();
    if (content.isEmpty) {
      print("NO FILE");
    } else {
      print(content);
      Wallet wallets = Wallet.fromJson(decrypt(content), passX);
      unlocked = await wallets.privateKey;

         }
  }

  FetchIPFS() async {
    String username = '1zPDRpuNnp13PuZF2rKPPT05i2M';
    String password = 'fadf76b64fcfbe02e43befe04a6e8aeb';
    var auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    dio
        .post('https://ipfs.infura.io:5001/api/v0/cat?arg=QmVn1znsuJbDrMwDjcNcXx5ppDnb6tMtMNkGiUUDBnntfP',
            data: {'param': []}, options: Options(headers: <String, String>{'authorization': auth}))
        .then((value) => {print(value)});
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0xF616B92B820EFe462F6D1A4A7C834E609ee806D1";

    final contract = DeployedContract(ContractAbi.fromJson(abi, "ERC20"), EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    var ethClient = new Web3Client(apiUrl, httpClient);
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);

    // This line below doesn't work.
    final result = await ethClient.call(contract: contract, function: ethFunction, params: args);

    // print(result.toString());
    return result;
  }

  Future<void> getBalance() async {
    final address = await unlocked.extractAddress();
//   EthereumAddress etherAddress = EthereumAddress.fromHex(address);
    List<dynamic> result = await query("balanceOf", [address]);
    publicKey = address.toString();
    print(address);
    print('In');
    print(result[0]);
    myData = result[0];
    print(myData.toString() + "YES");
    update();
  }

  Future<void> SendTransaction() async {
    var ethClient = new Web3Client(apiUrl, httpClient);
    EthereumAddress ownAddress = EthereumAddress.fromHex(await unlocked.extractAddress().toString());
    String abi = await rootBundle.loadString("assets/abi.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, "ERC20"), EthereumAddress.fromHex(loadContract.toString()));
    final sendFunction = contract.function('transfer');
    final balanceFunction = contract.function('balanceOf');

    final EthereumAddress receiver = EthereumAddress.fromHex('0x8319C0411957d80F73eb01128efB7cA914C21244');
    await ethClient
        .sendTransaction(
      unlocked,
      Transaction.callContract(
        from: ownAddress,
        contract: contract,
        function: sendFunction,
        parameters: [receiver, BigInt.from(10)],
        gasPrice: EtherAmount.inWei(BigInt.from(1000000)),
        maxGas: 100000,
      ),
      chainId: 4,
    )
        .then((value) async {
      print("DONE");
      print(value);
      final balance = await ethClient.call(contract: contract, function: balanceFunction, params: [ownAddress]);
      print('We have ${balance.first} EGPC');
    });
  }
}

/*
   Future<void> verifyPhone() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+2',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
    }
  }
*/
