pragma solidity >=0.4.21 <0.7.0;

pragma experimental ABIEncoderV2;

import "github.com/provable-things/ethereum-api/provableAPI_0.5.sol";

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}


 /**
 * @dev Interface to interact with HEX ERC20 tokens
 */
contract ERC20{
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
}

contract HEX2{
    function distribute(uint256 _amount) public returns (uint256);
}

 /**
 * @dev HexLotto game contract
 */
contract HexLotto is Ownable, usingProvable{

    using SafeMath for uint256;
     
    struct Entry {
        address buyer;
        uint256 tickets;
        uint256 hexAmount;
    }

    struct PlayerStats {
        uint256 totalAmount;
        uint256 totalTickets;
        uint256 amountWon;
    }

    mapping(bytes32 => uint8) validQueryIds;
    mapping(address => PlayerStats) public playerStats;

    uint256 public ticketPrice;
    uint256 public minimumPotAmount;
    uint256 public minimumParticipants;
    uint256 nonce;

    address token;
    address hex2;
    address devWallet;
 
    address[] public players;

    uint256 public hourlyPot;
    uint256 public dailyPot;
    uint256 public weeklyPot;
    uint256 public monthlyPot;
    uint256 public yearlyPot;
    uint256 public threeYearlyPot;

    uint256 public hourlyTickets;
    uint256 public dailyTickets;
    uint256 public weeklyTickets;
    uint256 public monthlyTickets;
    uint256 public yearlyTickets;
    uint256 public threeYearlyTickets;

    uint256 public hex2amount;
  
    uint256 public lastHourly = now;
    uint256 public lastDaily = now;
    uint256 public lastWeekly = now;
    uint256 public lastMonthly = now;
    uint256 public lastYearly = now;
    uint256 public lastThreeYearly = now;

    uint256 hour = 3600;
    uint256 day = 86400;
    uint256 week = 604800;
    uint256 month = 2629743;
    uint256 threeHundredDays = day * 300;
    uint256 threeYears = 31556926 * 3;

    uint256 hourlyGas;
    uint256 dailyGas;
    uint256 weeklyGas;
    uint256 monthlyGas;
    uint256 yearlyGas;
    uint256 threeYearlyGas;
  
    uint256 QUERY_EXECUTION_DELAY = 0;
    uint constant MAX_INT_FROM_BYTE = 256;
    uint constant NUM_RANDOM_BYTES_REQUESTED = 7;

    Entry[] public hourlyParticipants;
    Entry[] public dailyParticipants;
    Entry[] public weeklyParticipants;
    Entry[] public monthlyParticipants;
    Entry[] public yearlyParticipants;
    Entry[] public threeYearlyParticipants;

    event LogNewProvableQuery(
        string description
    );

    event generatedRandomNumber(
        uint256 randomNumber
    );

    event Enter(
        address indexed from, 
        uint amount, 
        uint time
    );

    constructor() public {
        //HexToken address
        token = address(0x2b591e99afE9f32eAA6214f7B7629768c40Eeb39); 
        hex2 = address(0xD495cC8C7c29c7fA3E027a5759561Ab68C363609); 
        devWallet = address(0x35e9034f47cc00b8A9b555fC1FDB9598b2c245fD);

        nonce = 1;
        minimumParticipants = 3;
        ticketPrice = 500000000000; //default ticket price 5000 HEX
        minimumPotAmount = 2550000000000; //default min pot amount 25500 HEX
        
        hourlyGas = 400000;
        dailyGas = 400000;
        weeklyGas = 400000;
        monthlyGas = 400000;
        yearlyGas = 800000;
        threeYearlyGas = 800000;

        //Set proof type for provable oracle
        provable_setProof(proofType_Ledger);
    }

    /**
     * @dev Allows contract owner to change gas amount needed for provable Oracle callback
    */
    function setGasAmounts(
        uint256 newHour, 
        uint256 newDay, 
        uint256 newWeek, 
        uint256 newMonth, 
        uint256 newYear, 
        uint256 newThreeYears
    ) public onlyOwner{
        require(
            newHour > 0 && newDay > 0 && newWeek > 0 && newMonth > 0 && newYear > 0 && newThreeYears > 0,
            "Gas values must be positive"
        );

        hourlyGas = newHour;
        dailyGas = newDay;
        weeklyGas = newWeek;
        monthlyGas = newMonth;
        yearlyGas = newYear;
        threeYearlyGas = newThreeYears;
    }
    
    /**
     * @dev Sets ticket price for a single lotto ticket
    */
    function setTicketPrice(uint256 amount) public onlyOwner{
        require(amount > 0, "amount must be greater than 0");
        ticketPrice = amount;
    }

    /**
     * @dev Sets the minimum pot for all tiers before game can finish
    */
    function setMinimumPot(uint256 amount) public onlyOwner{
        require(amount > 0, "amount must be greater than 0");
        minimumPotAmount = amount;
    }

    /**
     * @dev Array getter functions
    */
    function getHourlyParticipants() public view returns(Entry[] memory) {
        return hourlyParticipants;
    }

    function getDailyParticipants() public view returns(Entry[] memory) {
        return dailyParticipants;
    }

    function getWeeklyParticipants() public view returns(Entry[] memory) {
        return weeklyParticipants;
    }

    function getMonthlyParticipants() public view returns(Entry[] memory) {
        return monthlyParticipants;
    }

    function getYearlyParticipants() public view returns(Entry[] memory) {
        return yearlyParticipants;
    }

    function getThreeYearlyParticipants() public view returns(Entry[] memory) {
        return threeYearlyParticipants;
    }

    function getPlayers() public view returns(address[] memory) {
        return players;
    }

    /**
     * @dev Distributes HEX quantities into the relevant tiers, treasury wallets and approves for HEX2
    */
    function distribute(uint256 quantity) private returns(uint256[9] memory) {
        uint256[9] memory quantities;
        
        quantities[0] = quantity.mul(34).div(100); //Hourly
        quantities[1] = quantity.mul(23).div(100); //Daily
        quantities[2] = quantity.mul(18).div(100); //Weekly
        quantities[3] = quantity.mul(10).div(100); //Monthly
        quantities[4] = quantity.mul(4).div(100); //300 days
        quantities[5] = quantity.mul(1).div(100); //3 yearly
        quantities[6] = quantity.mul(6).div(100); //Treasury 
        quantities[7] = quantity.mul(1).div(100); //Hex2
        quantities[8] = quantity.mul(3).div(100); //Dev wallet
        
        //send 6% to treasury 
        require(ERC20(token).transfer(owner(), quantities[6]));

        //approve 1% for hex2 distribution
        //need to call hex distribute function after tokens are approved
        ERC20(token).approve(hex2, quantities[7]);
        hex2amount += quantities[7];

        //send 3% to dev
        require(ERC20(token).transfer(devWallet, quantities[8]));

        hourlyPot += quantities[0];
        dailyPot += quantities[1];
        weeklyPot += quantities[2];
        monthlyPot += quantities[3];
        yearlyPot += quantities[4];
        threeYearlyPot += quantities[5];

        return quantities;
    }

    /**
     * @dev Buys 'tickets' for lottery and splits tokens into tier entries
     * User must call approve with this contract address before entering
    */
    function entry (uint256 tickets) public{

        uint256 quantity = ticketPrice.mul(tickets);

        //get the user's balance
        uint256 userBalance = ERC20(token).balanceOf(msg.sender);

        //check user's balance
        require(userBalance >= quantity, "Not enough HEX tokens in balance.");

        //transfer pre approved amount to contract       
        require(ERC20(token).transferFrom(msg.sender, address(this), quantity), "Transfer failed.");        
        
        // 34% Hourly, 23% Daily, 18% Weekly, 10% Monthly, 4% 300 Days, and 1% 3 Years
        uint256[9] memory quantities = distribute(quantity);        

        saveEntries(tickets, quantities);
     
        playerStats[msg.sender].totalAmount += quantity;
        playerStats[msg.sender].totalTickets += tickets;

        emit Enter(msg.sender, quantity, now);
     }

    /**
    * @dev Creates ticket entries into arrays for all tiers
    */
    function saveEntries(uint256 tickets, uint256[9] memory quantities ) private {
        Entry memory hourlyEntry = Entry(msg.sender, tickets, quantities[0]);
        Entry memory dailyEntry = Entry(msg.sender, tickets, quantities[1]);
        Entry memory weeklyEntry = Entry(msg.sender, tickets, quantities[2]);
        Entry memory monthlyEntry = Entry(msg.sender, tickets, quantities[3]);
        Entry memory yearlyEntry = Entry(msg.sender, tickets, quantities[4]);
        Entry memory threeYearlyEntry = Entry(msg.sender, tickets, quantities[5]);

        hourlyParticipants.push(hourlyEntry);
        dailyParticipants.push(dailyEntry);
        weeklyParticipants.push(weeklyEntry);
        monthlyParticipants.push(monthlyEntry);
        yearlyParticipants.push(yearlyEntry);
        threeYearlyParticipants.push(threeYearlyEntry);

        hourlyTickets += tickets;
        dailyTickets += tickets;
        weeklyTickets += tickets;
        monthlyTickets += tickets;
        yearlyTickets += tickets;
        threeYearlyTickets += tickets;

        players.push(msg.sender);
    }
         
    /**
    * @dev Calls provable oracle to return random number
    */
     function provableRandomNumber(uint8 tier) private {

        uint256 gasAmount;

        if (tier == 0) {
            gasAmount = hourlyGas;
        }
        else if (tier == 1) {
            gasAmount = dailyGas;
        }
        else if (tier == 2) {
            gasAmount = weeklyGas;
        }
        else if (tier == 3) {
            gasAmount = monthlyGas;
        }
        else if (tier == 4) {
            gasAmount = yearlyGas;
        }
        else if (tier == 5) {
            gasAmount = threeYearlyGas;
        }
        else {
            gasAmount = hourlyGas;
        }

        bytes32 queryId = provable_newRandomDSQuery(
            QUERY_EXECUTION_DELAY,
            NUM_RANDOM_BYTES_REQUESTED,
            gasAmount
        );

        validQueryIds[queryId] = tier; //0 = hourly tier, 1 = daily, 2 = weekly, 3 = monthly, 4 = yearly, 5 = 3 yearly

        emit LogNewProvableQuery("Provable query for prize was sent, waiting for random number...");
     }
    
    /**
    * @dev Generates a random number based on the provable oracle result
    */
    function generateRandomNumber(string memory provableResult) private returns(uint256) {
        //Convert provable random result into a random number
        uint ceiling = (MAX_INT_FROM_BYTE ** NUM_RANDOM_BYTES_REQUESTED) - 1;
        nonce++;
        return uint256(keccak256(abi.encodePacked(now, provableResult, nonce))) % ceiling;
    }

    /**
    * @dev Distributes the total currently approved amount to the hex2 contract distribution
    */
    function distributeToHex2() public {
        HEX2(hex2).distribute(hex2amount);
    }

    /**
    * @dev Schedule to call once per hour
    * Finishes current game and calls provable random number
    */
    function finishHourly() external {
        require(now > lastHourly.add(hour), "Can only finish game once per hour.");
        require(hourlyParticipants.length >= minimumParticipants);
        require(hourlyPot > minimumPotAmount, "Hourly pot needs to be higher before game can finish");
        
        provableRandomNumber(0);
    }

     /**
    * @dev Transfers prize to random winner
    */
    function pickHourlyWinner(uint256 random) private {
        
        uint256 randomWinner = random % hourlyTickets - 1;
        address hourlyWinner = pickWinner(hourlyParticipants, randomWinner);
        
        require(hourlyWinner != address(0), "Can not send to 0 address");
        require(ERC20(token).transfer(hourlyWinner, hourlyPot), "transfer failed");
        playerStats[hourlyWinner].amountWon += hourlyPot;

        lastHourly = now;      
        hourlyPot = 0;
        hourlyTickets = 0;
        delete hourlyParticipants;
     }
     
    /**
    * @dev Schedule to call once per day
    * Finishes current game and calls provable random number
    */
    function finishDaily() external {
        require(now > lastDaily.add(day),  "Can only finish game once per day.");
        require(dailyParticipants.length >= minimumParticipants);
        require(dailyPot > minimumPotAmount, "Daily pot needs to be higher before game can finish");
        
        provableRandomNumber(1);
    }

    /**
    * @dev Transfers prize to random winner
    */
    function pickDailyWinner(uint256 random) private {
        uint256 randomWinner = random % dailyTickets - 1;
        address dailyWinner = pickWinner(dailyParticipants, randomWinner);
        require(dailyWinner != address(0), "Can not send to 0 address");

        require(ERC20(token).transfer(dailyWinner, dailyPot), "Transfer failed");
        playerStats[dailyWinner].amountWon += dailyPot;
        
        lastDaily = now;
        dailyPot = 0;
        dailyTickets = 0;
        delete dailyParticipants;
     }

    /**
    * @dev Schedule to call once per week
    * Finishes current game and calls provable random number
    */
    function finishWeekly() external {
        require(now > lastWeekly.add(week),  "Can only finish game once per week.");
        require(weeklyParticipants.length >= minimumParticipants);
        require(weeklyPot > minimumPotAmount, "Weekly pot needs to be higher before game can finish");
        
        provableRandomNumber(2);
    }

    /**
    * @dev Transfers prize to random winner
    */
    function pickWeeklyWinner(uint256 random, uint256 prizeAmount) private  {
        uint256 randomWinner = random % weeklyTickets - 1;
        address weeklyWinner = pickWinner(weeklyParticipants, randomWinner);
        require(weeklyWinner != address(0), "Can not send to 0 address");

        require(ERC20(token).transfer(weeklyWinner, prizeAmount), "Transfer failed");
        playerStats[weeklyWinner].amountWon += prizeAmount;
        
        weeklyPot -= prizeAmount;

        if(weeklyPot < 2){
            lastWeekly = now;
            weeklyTickets = 0;
            delete weeklyParticipants;
        }
     }
     
    /**
    * @dev Schedule to call once per month
    * Finishes current game and calls provable random number
    */
    function finishMonthly() external { 
        require(now > lastMonthly.add(month),  "Can only finish game once per month.");
        require(monthlyParticipants.length >= minimumParticipants);
        require(monthlyPot > minimumPotAmount, "Monthly pot needs to be higher before game can finish");

        provableRandomNumber(3);
       
    }
     
    /**
    * @dev Transfers prize to random winner
    */
    function pickMonthlyWinner(uint256 random, uint256 prizeAmount) private {
        uint256 randomWinner = random % monthlyTickets - 1;
        address monthlyWinner = pickWinner(monthlyParticipants, randomWinner);
        require(monthlyWinner != address(0), "Can not send to 0 address");

        require(ERC20(token).transfer(monthlyWinner, prizeAmount), "Transfer failed");
        playerStats[monthlyWinner].amountWon += prizeAmount;

        monthlyPot -= prizeAmount;

        if(monthlyPot < 3) {
            lastMonthly = now;
            monthlyTickets = 0;
            delete monthlyParticipants;
        }
     }

    /**
    * @dev Schedule to call once per year
    * Finishes current game and calls provable random number
    */
    function finishYearly() external {
        require(now > lastYearly.add(threeHundredDays),  "Can only finish game once every 300 days.");
        require(yearlyParticipants.length >= minimumParticipants);
        require(yearlyPot > minimumPotAmount, "Yearly pot needs to be higher before game can finish");
        
        //Picks 6 random winners from yearly participants based on number of entries
        provableRandomNumber(4);  
    }
    
    /**
    * @dev Transfers prize to random winner
    */
    function pickYearlyWinner(uint256 random, uint256 prizeAmount) private {
        uint256 randomWinner = random % yearlyTickets - 1;
        address yearlyWinner = pickWinner(yearlyParticipants, randomWinner);
         require(yearlyWinner != address(0), "Can not send to 0 address");

        require(ERC20(token).transfer(yearlyWinner, prizeAmount), "Transfer failed");
        playerStats[yearlyWinner].amountWon += prizeAmount;
        
        yearlyPot -= prizeAmount;
        
        if(yearlyPot < 6){
            lastYearly = now;
            yearlyTickets = 0;
            delete yearlyParticipants;
        }
     }

    /**
    * @dev Schedule to call once every 3 years
    * Finishes current game and calls provable random number
    */
    function finishThreeYearly() external {
        require(now > lastThreeYearly.add(threeYears),  "Can only finish game every three years.");
        require(threeYearlyParticipants.length >= minimumParticipants);
        require(threeYearlyPot >  minimumPotAmount, "3 yearly pot needs to be higher before game can finish");

        provableRandomNumber(5);
    }
    
    /**
    * @dev Transfers prize to random winner
    */
    function pickThreeYearlyWinner(uint256 random) private {
        uint256 randomWinner = random % threeYearlyTickets - 1;
        address threeYearlyWinner = pickWinner(threeYearlyParticipants, randomWinner);
        require(threeYearlyWinner != address(0), "Can not send to 0 address");

        require(ERC20(token).transfer(threeYearlyWinner, threeYearlyPot), "Transfer failed");
        playerStats[threeYearlyWinner].amountWon += threeYearlyPot;

        lastThreeYearly = now;
        threeYearlyPot = 0;
        threeYearlyTickets = 0;
        delete threeYearlyParticipants;
     }

    /**
     * @dev callback function used by provable to process random number 
     */
    function __callback(
        bytes32 _queryId,
        string memory _result,
        bytes memory _proof
    )
        public
    {
        require(msg.sender == provable_cbAddress());

        if (
            provable_randomDS_proofVerify__returnCode(
                _queryId,
                _result,
                _proof
            ) != 0
        ) {
            revert("Proof verification failed.");
        } else {            
            
            uint8 thisTier = validQueryIds[_queryId];
           
            if(thisTier == 0) { 
                pickHourlyWinner(generateRandomNumber(_result));
            }
            if(thisTier == 1) {
                pickDailyWinner(generateRandomNumber(_result));
            }
            if(thisTier == 2) {
                uint256 firstWeeklyPrize = weeklyPot.mul(70).div(100);
                uint256 secondWeeklyPrize = weeklyPot.mul(30).div(100);
                pickWeeklyWinner(generateRandomNumber(_result), firstWeeklyPrize);
                pickWeeklyWinner(generateRandomNumber(_result), secondWeeklyPrize);
            }
            if(thisTier == 3) {
                uint256 firstMonthlyPrize = monthlyPot.mul(50).div(100);
                uint256 secondMonthlyPrize = monthlyPot.mul(30).div(100);
                uint256 thirdMonthlyPrize = monthlyPot.mul(20).div(100);

                pickMonthlyWinner(generateRandomNumber(_result), firstMonthlyPrize);
                pickMonthlyWinner(generateRandomNumber(_result), secondMonthlyPrize);
                pickMonthlyWinner(generateRandomNumber(_result), thirdMonthlyPrize);
            }
            if(thisTier == 4) {
                uint256 yearlyPrize = yearlyPot.div(6);
                for(uint i=0; i<6; i++){
                    pickYearlyWinner(generateRandomNumber(_result), yearlyPrize);
                }
            }
            if(thisTier == 5) {
                pickThreeYearlyWinner(generateRandomNumber(_result));
            }
  
            delete validQueryIds[_queryId];
        }
    }

    /**
    * @dev Returns a winner address chosen at random from the participant list
    */
    function pickWinner(Entry[] memory entries, uint256 random) internal returns(address) {

        address winner;

        uint256 counter = random;
        for (uint i=0; i < entries.length; i++) {
            uint quantity = entries[i].tickets;
            if (quantity >= counter) {
                winner = entries[i].buyer;
                break;
            } else {
                counter -= quantity;
            }
        }

        emit generatedRandomNumber(random);
        return winner;
     }

    /**
    * @dev Default payable function, need eth for provable call
    */
    function() external payable {
      
    }
}