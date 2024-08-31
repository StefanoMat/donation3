// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC1155 {

//transfer of only unique token for execution

  function safeTransferFrom(
    address _from,
    address _to,
    uint256 _id,
    uint256 _value,
    bytes calldata _data
  ) external;

//transfer batch of tokens in unique moment for cheaping the gas custom and is specified for ids of tokens

  function safeBatchTransferFrom(
    address _from,
    address _to,
    uint256[] calldata _ids,
    uint256[] calldata _values,
    bytes calldata _data
  ) external;

//the function balanceOf receive the address of the owner and the id of the token
//in a multi-token standart each different token receive a id
//permit semi-fungible token have a limit of wallet

  function balanceOf (address _owner, uint256 _id)
    external
    view
    returns (uint256);

//the function balanceOfBatch receive a list of owners and ids of tokens
//the list need to have the same length of the owners and ids

  function balanceOfBatch(address[] calldata _owners, uint256[] calldata _ids)
    external
    view
    returns (uint256[] memory);

//permit the smartcontract or marketplace execute transcations involving multi-tokens
//the _operator is the smartcontract or marketplace??

  function setApprovalForAll(address _operator, bool _approved) external;

//verify if the tokens of owner stay to control of the operator

  function isApprovedForAll(address _owner, address _operator)
    external
    view
    returns (bool);
}

interface IERC1155TokenReceiveir {
  function onERC1155Received(
    address _operator,
    address _from,
    uint256 _id,
    uint256 _value,
    bytes calldata _data
  ) external returns (bytes4);

  function onERC115BatchReceived(
    address _operator,
    address _from,
    uint256[] calldata _ids,
    uint256[] calldata _values,
    bytes calldata _data
  ) external returns (bytes4);
}

contract ERC1155 is IERC1155 {

  /* ** all events is required on contracts ERC1155 ** */

  // the TransferSingle event is emit when a token swap owner, incluing mint and burn cases

  event TransferSingle (
    address indexed _operator,
    address indexed _from,
    address indexed _to,
    uint256 _id,
    uint256 _value
  );

  // is emit when a batch of tokens swap owner

  event TransferBatch (
    address indexed _operator,
    address indexed _from,
    address indexed _to,
    uint256[] ids,
    uint256[] values
  );

  // is emit when the account change the permission for the operator transfer your tokens

  event ApprovalForAll (
    address indexed _owner,
    address indexed _operator,
    bool _approved
  );

  event URI(
    string _value,
    uint256 indexed _id
  );
}