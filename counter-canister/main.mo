import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

actor {
    stable var currentValue: Nat = 0;

    public func increment(): async () {
        currentValue += 1;
    };

    public query func getValue(): async Nat {
        currentValue;
    };

    let users = HashMap.HashMap<Text, Text>(16, Text.equal, Text.hash);

    public func storeid(proton_account : Text, principal_id : Text) : async Text {
        
        users.put(proton_account, principal_id);

        let numusers = users.size();

        return principal_id # " and " # proton_account # ", number of users = " # Nat.toText(numusers);
    };

    public func getUsers() : async Text {

        let numusers = users.size();

        return Nat.toText(numusers);
    };
};
