import { Clarinet, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.0.0/index.ts';

Clarinet.test({
  name: "Ensures user can record health metrics",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get("deployer")!;
    const wallet1 = accounts.get("wallet_1")!;
    
    let block = chain.mineBlock([
      Tx.contractCall(
        "pulse-mesh-data",
        "record-health-metrics",
        [types.uint(10000), types.uint(75), types.uint(2000)],
        wallet1.address
      )
    ]);
    
    block.receipts[0].result.expectOk();
  }
});
