// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @dev Standard math utilities missing in the Solidity language.
 */
library Math {
    /**
     * @dev Returns the largest of two numbers.
     */
    function max(uint256 a, uint256 b) public pure returns (uint256) {
        return a >= b ? a : b;
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    function min(uint256 a, uint256 b) public pure returns (uint256) {
        return a < b ? a : b;
    }

    /**
     * @dev Returns the average of two numbers. The result is rounded towards
     * zero.
     */
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow, so we distribute
        return (a / 2) + (b / 2) + ((a % 2 + b % 2) / 2);
    }
    
    /**
     * @dev Returns the hyperbolic tangent of a number with a scaling factor
     */

     function tanh(int x , int _scale) public pure returns (int256) {
        if (x >= 0) {
            return (exp(x) - exp(-x)) * _scale / (exp(x) + exp(-x));
        } else {
            return (-exp(-x) + exp(x)) * _scale / (exp(-x) + exp(x));
        }
    }

    // Approximation of the exponential function (e^x)
    function exp(int256 x) private pure returns (int256) {
        int  EXP_SCALE = 1000;
        int  EXP_PRECISION = 10;

        int result = EXP_SCALE;

        for (int i = EXP_PRECISION - 1; i > 0; i--) {
            result = (result * x) / (i) + EXP_SCALE;
        }

        return result;
    }
}