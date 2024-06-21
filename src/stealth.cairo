use starknet::ContractAddress;
use starknet::{
    secp256_trait::{
        Secp256Trait, Secp256PointTrait, recover_public_key, is_signature_entry_valid, Signature
    },
    SyscallResult, SyscallResultTrait
};

#[starknet::interface]
pub trait IStealthWealth<TContractState> {}

#[starknet::contract]
mod StealthWealth {
use core::clone::Clone;
use core::box::BoxTrait;
use core::option::OptionTrait;
use starknet::{ContractAddress, get_caller_address, storage_access::StorageBaseAddress};
    use stealth::utils::{StealthMetaAddress, PublicKeyCompressed, PublicKeyUncompressed};
    use core::integer::u8;

    use core::array::ArrayTrait;

    #[storage]
    struct Storage {}

    #[derive(Drop, Serde, starknet::Store)]
    pub enum RegistrationType {
        finite: u64,
        infinite
    }

    #[constructor]
    fn constructor(ref self: ContractState) {}

    // Public functions inside an impl block
    #[abi(embed_v0)]
    impl StealthWealth of super::IStealthWealth<ContractState> {}

    // Standalone public function
    #[external(v0)]
    fn get_contract_name(self: @ContractState) -> felt252 {
        'Stealth Wealth'
    }

    // Could be a group of functions about a same topic
    #[generate_trait]
    impl InternalFunctions of InternalFunctionsTrait {

        fn split_stealth_meta_address(
            ref self: ContractState,
            encoded: StealthMetaAddress
        ) -> (PublicKeyCompressed, PublicKeyCompressed) {

            // Create arrays for front and back
            let mut front = ArrayTrait::<u8>::new();
            let mut back = ArrayTrait::<u8>::new();

            // Copy elements to the front array
            let mut i: u32 = 0;
            while i < 33 {
                front.append(*encoded.get(i).unwrap().unbox());
                back.append(*encoded.get(i+33).unwrap().unbox());
                i += 1;
            };

            return (front, back);
        }
    }

}