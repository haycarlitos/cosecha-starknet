%lang starknet

from starkware.cairo.common.uint256 import Uint256, uint256_add
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import unsigned_div_rem, split_felt
from starkware.cairo.common.alloc import alloc


from openzeppelin.access.ownable.library import Ownable
from openzeppelin.introspection.erc165.library import ERC165
from openzeppelin.token.erc721.library import ERC721

// ------
// Structs
// ------

struct UserInfo {
    name: felt,
    last_name: felt,
    id_cedula: felt,
    application_number: felt,
    already_approved: felt,
    licence_number: felt,
    accepting_collaborations: felt,
}

// struct ReadyToCollab {
//     len : felt,
//     id_cedulas: felt*,

// }

// ------
// Storage
// ------

@storage_var
func token_counter() -> (number: Uint256) {
}

@storage_var
func id_to_user_info(id: felt) -> (user_info: UserInfo) {
}

@storage_var
func address_to_user_info(address: felt) -> (user_info: UserInfo) {
}

// @storage_var
// func len_current_ready_to_collab() -> (res: felt) {
// }

// @storage_var
// func current_ready_to_collab() -> (res: ReadyToCollab) {
// }



// ------
// Constructor
// ------

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    
) {
    alloc_locals;
    // "cosecha"
    let name = 27988564107290721;
    // "COS"
    let symbol = 4411219;
    let owner = 1268012686959018685956609106358567178896598707960497706446056576062850827536;

    token_counter.write(Uint256(0,0));
    ERC721.initializer(name, symbol);
    Ownable.initializer(owner);

    return ();
}

// ------
// Getters
// ------

@view
func get_number_of_users_registered{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (tokenID: Uint256) {
    let last_token : Uint256 = token_counter.read();
    return (tokenID=last_token);
}

@view
func get_user_info_by_ID_cedula{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(id_cedula: felt) -> (info: UserInfo) {
    let user_info : UserInfo = address_to_user_info.read(id_cedula);
    return (info=user_info);
}

@view
func get_user_info_by_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(address: felt) -> (info: UserInfo) {
    let user_info : UserInfo = address_to_user_info.read(address);
    return (info=user_info);
}

@view
func get_user_info{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(id_cedula: felt) -> (info: UserInfo) {
    let user_info : UserInfo = id_to_user_info.read(id_cedula);
    return (info=user_info);
}

@view
func name_of_project{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (name: felt) {
    return ERC721.name();
}

@view
func symbol_of_project{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (symbol: felt) {
    return ERC721.symbol();
}


// ------
// Non-Constant Functions: state-changing functions
// ------

@external
func register_yourself{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    name: felt, last_name: felt, id_cedula: felt, application_number: felt
) -> () {
    alloc_locals;
    
    //  Register user
    local user_info : UserInfo;
    
    assert user_info.name=name;
    assert user_info.last_name=last_name;
    assert user_info.id_cedula=id_cedula;
    assert user_info.application_number=application_number;
    assert user_info.already_approved=0;
    assert user_info.licence_number=0;
    assert user_info.accepting_collaborations=0;

    // Store user info
    let (caller_address: felt) = get_caller_address();
    id_to_user_info.write(user_info.id_cedula, user_info);
    address_to_user_info.write(caller_address, user_info);

    // TODO: do not allowed previously registered individuals to register again

    // Update new tokenID
    let last_token : Uint256 = token_counter.read();
    let one_uint : Uint256 = Uint256(1,0);
    let (new_tokenID, _ ) = uint256_add(a=last_token, b=one_uint);
    token_counter.write(new_tokenID);

    // Mint
    ERC721._mint(to=caller_address, token_id=new_tokenID);

    return();
}

@external
func got_my_license_approved{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    licence_number: felt, accepting_collaborations: felt
) {
    alloc_locals;
    // TODO - check user is registered

    // Change user info to reflect the approval of the license
    let (caller_address: felt) = get_caller_address();
    let user_info : UserInfo = address_to_user_info.read(caller_address);

    local new_user_info : UserInfo;
    assert new_user_info.name=user_info.name;
    assert new_user_info.last_name=user_info.last_name;
    assert new_user_info.id_cedula=user_info.id_cedula;
    assert new_user_info.application_number=user_info.application_number;
    assert new_user_info.already_approved=1;
    assert new_user_info.licence_number=licence_number;
    assert new_user_info.accepting_collaborations=accepting_collaborations;

    id_to_user_info.write(new_user_info.id_cedula, new_user_info);

    // 

    
    return();
}