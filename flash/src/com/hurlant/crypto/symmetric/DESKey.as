﻿package com.hurlant.crypto.symmetric
{
    import com.hurlant.crypto.symmetric.*;
    import com.hurlant.util.*;
    import flash.utils.*;

    public class DESKey extends Object implements ISymmetricKey
    {
        protected var encKey:Array;
        protected var key:ByteArray;
        protected var decKey:Array;
        private static const SP8:Array = [268439616, 4096, 262144, 268701760, 268435456, 268439616, 64, 268435456, 262208, 268697600, 268701760, 266240, 268701696, 266304, 4096, 64, 268697600, 268435520, 268439552, 4160, 266240, 262208, 268697664, 268701696, 4160, 0, 0, 268697664, 268435520, 268439552, 266304, 262144, 266304, 262144, 268701696, 4096, 64, 268697664, 4096, 266304, 268439552, 64, 268435520, 268697600, 268697664, 268435456, 262144, 268439616, 0, 268701760, 262208, 268435520, 268697600, 268439552, 268439616, 0, 268701760, 266240, 266240, 4160, 4160, 262208, 268435456, 268701696];
        private static const bytebit:Array = [128, 64, 32, 16, 8, 4, 2, 1];
        private static const bigbyte:Array = [8388608, 4194304, 2097152, 1048576, 524288, 262144, 131072, 65536, 32768, 16384, 8192, 4096, 2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1];
        private static const pc1:Array = [56, 48, 40, 32, 24, 16, 8, 0, 57, 49, 41, 33, 25, 17, 9, 1, 58, 50, 42, 34, 26, 18, 10, 2, 59, 51, 43, 35, 62, 54, 46, 38, 30, 22, 14, 6, 61, 53, 45, 37, 29, 21, 13, 5, 60, 52, 44, 36, 28, 20, 12, 4, 27, 19, 11, 3];
        private static const pc2:Array = [13, 16, 10, 23, 0, 4, 2, 27, 14, 5, 20, 9, 22, 18, 11, 3, 25, 7, 15, 6, 26, 19, 12, 1, 40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47, 43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 28, 31];
        private static const Df_Key:Array = [1, 35, 69, 103, 137, 171, 205, 239, 254, 220, 186, 152, 118, 84, 50, 16, 137, 171, 205, 239, 1, 35, 69, 103];
        private static const totrot:Array = [1, 2, 4, 6, 8, 10, 12, 14, 15, 17, 19, 21, 23, 25, 27, 28];
        private static const SP1:Array = [16843776, 0, 65536, 16843780, 16842756, 66564, 4, 65536, 1024, 16843776, 16843780, 1024, 16778244, 16842756, 16777216, 4, 1028, 16778240, 16778240, 66560, 66560, 16842752, 16842752, 16778244, 65540, 16777220, 16777220, 65540, 0, 1028, 66564, 16777216, 65536, 16843780, 4, 16842752, 16843776, 16777216, 16777216, 1024, 16842756, 65536, 66560, 16777220, 1024, 4, 16778244, 66564, 16843780, 65540, 16842752, 16778244, 16777220, 1028, 66564, 16843776, 1028, 16778240, 16778240, 0, 65540, 66560, 0, 16842756];
        private static const SP2:Array = [2148565024, 2147516416, 32768, 1081376, 1048576, 32, 2148532256, 2147516448, 2147483680, 2148565024, 2148564992, 2147483648, 2147516416, 1048576, 32, 2148532256, 1081344, 1048608, 2147516448, 0, 2147483648, 32768, 1081376, 2148532224, 1048608, 2147483680, 0, 1081344, 32800, 2148564992, 2148532224, 32800, 0, 1081376, 2148532256, 1048576, 2147516448, 2148532224, 2148564992, 32768, 2148532224, 2147516416, 32, 2148565024, 1081376, 32, 32768, 2147483648, 32800, 2148564992, 1048576, 2147483680, 1048608, 2147516448, 2147483680, 1048608, 1081344, 0, 2147516416, 32800, 2147483648, 2148532256, 2148565024, 1081344];
        private static const SP3:Array = [520, 134349312, 0, 134348808, 134218240, 0, 131592, 134218240, 131080, 134217736, 134217736, 131072, 134349320, 131080, 134348800, 520, 134217728, 8, 134349312, 512, 131584, 134348800, 134348808, 131592, 134218248, 131584, 131072, 134218248, 8, 134349320, 512, 134217728, 134349312, 134217728, 131080, 520, 131072, 134349312, 134218240, 0, 512, 131080, 134349320, 134218240, 134217736, 512, 0, 134348808, 134218248, 131072, 134217728, 134349320, 8, 131592, 131584, 134217736, 134348800, 134218248, 520, 134348800, 131592, 8, 134348808, 131584];
        private static const SP4:Array = [8396801, 8321, 8321, 128, 8396928, 8388737, 8388609, 8193, 0, 8396800, 8396800, 8396929, 129, 0, 8388736, 8388609, 1, 8192, 8388608, 8396801, 128, 8388608, 8193, 8320, 8388737, 1, 8320, 8388736, 8192, 8396928, 8396929, 129, 8388736, 8388609, 8396800, 8396929, 129, 0, 0, 8396800, 8320, 8388736, 8388737, 1, 8396801, 8321, 8321, 128, 8396929, 129, 1, 8192, 8388609, 8193, 8396928, 8388737, 8193, 8320, 8388608, 8396801, 128, 8388608, 8192, 8396928];
        private static const SP5:Array = [256, 34078976, 34078720, 1107296512, 524288, 256, 1073741824, 34078720, 1074266368, 524288, 33554688, 1074266368, 1107296512, 1107820544, 524544, 1073741824, 33554432, 1074266112, 1074266112, 0, 1073742080, 1107820800, 1107820800, 33554688, 1107820544, 1073742080, 0, 1107296256, 34078976, 33554432, 1107296256, 524544, 524288, 1107296512, 256, 33554432, 1073741824, 34078720, 1107296512, 1074266368, 33554688, 1073741824, 1107820544, 34078976, 1074266368, 256, 33554432, 1107820544, 1107820800, 524544, 1107296256, 1107820800, 34078720, 0, 1074266112, 1107296256, 524544, 33554688, 1073742080, 524288, 0, 1074266112, 34078976, 1073742080];
        private static const SP6:Array = [536870928, 541065216, 16384, 541081616, 541065216, 16, 541081616, 4194304, 536887296, 4210704, 4194304, 536870928, 4194320, 536887296, 536870912, 16400, 0, 4194320, 536887312, 16384, 4210688, 536887312, 16, 541065232, 541065232, 0, 4210704, 541081600, 16400, 4210688, 541081600, 536870912, 536887296, 16, 541065232, 4210688, 541081616, 4194304, 16400, 536870928, 4194304, 536887296, 536870912, 16400, 536870928, 541081616, 4210688, 541065216, 4210704, 541081600, 0, 541065232, 16, 16384, 541065216, 4210704, 16384, 4194320, 536887312, 0, 541081600, 536870912, 4194320, 536887312];
        private static const SP7:Array = [2097152, 69206018, 67110914, 0, 2048, 67110914, 2099202, 69208064, 69208066, 2097152, 0, 67108866, 2, 67108864, 69206018, 2050, 67110912, 2099202, 2097154, 67110912, 67108866, 69206016, 69208064, 2097154, 69206016, 2048, 2050, 69208066, 2099200, 2, 67108864, 2099200, 67108864, 2099200, 2097152, 67110914, 67110914, 69206018, 69206018, 2, 2097154, 67108864, 67110912, 2097152, 69208064, 2050, 2099202, 69208064, 2050, 67108866, 69208066, 69206016, 2099200, 0, 2, 69208066, 0, 2099202, 69206016, 2048, 67108866, 67110912, 2048, 2097154];

        public function DESKey(param1:ByteArray)
        {
            this.key = param1;
            this.encKey = generateWorkingKey(true, param1, 0);
            this.decKey = generateWorkingKey(false, param1, 0);
            return;
        }// end function

        protected function generateWorkingKey(param1:Boolean, param2:ByteArray, param3:uint) : Array
        {
            var _loc_4:Array = null;
            var _loc_5:ByteArray = null;
            var _loc_6:ByteArray = null;
            var _loc_7:uint = 0;
            var _loc_8:uint = 0;
            var _loc_9:uint = 0;
            var _loc_10:uint = 0;
            var _loc_11:uint = 0;
            var _loc_12:uint = 0;
            var _loc_13:uint = 0;
            _loc_4 = [];
            _loc_5 = new ByteArray();
            _loc_6 = new ByteArray();
            _loc_8 = 0;
            while (_loc_8 < 56)
            {
                
                _loc_7 = pc1[_loc_8];
                _loc_5[_loc_8] = (param2[param3 + (_loc_7 >>> 3)] & bytebit[_loc_7 & 7]) != 0;
                _loc_8 = _loc_8 + 1;
            }
            _loc_9 = 0;
            while (_loc_9 < 16)
            {
                
                if (param1)
                {
                    _loc_10 = _loc_9 << 1;
                }
                else
                {
                    _loc_10 = 15 - _loc_9 << 1;
                }
                _loc_11 = _loc_10 + 1;
                var _loc_14:int = 0;
                _loc_4[_loc_11] = 0;
                _loc_4[_loc_10] = _loc_14;
                _loc_8 = 0;
                while (_loc_8 < 28)
                {
                    
                    _loc_7 = _loc_8 + totrot[_loc_9];
                    if (_loc_7 < 28)
                    {
                        _loc_6[_loc_8] = _loc_5[_loc_7];
                    }
                    else
                    {
                        _loc_6[_loc_8] = _loc_5[_loc_7 - 28];
                    }
                    _loc_8 = _loc_8 + 1;
                }
                _loc_8 = 28;
                while (_loc_8 < 56)
                {
                    
                    _loc_7 = _loc_8 + totrot[_loc_9];
                    if (_loc_7 < 56)
                    {
                        _loc_6[_loc_8] = _loc_5[_loc_7];
                    }
                    else
                    {
                        _loc_6[_loc_8] = _loc_5[_loc_7 - 28];
                    }
                    _loc_8 = _loc_8 + 1;
                }
                _loc_8 = 0;
                while (_loc_8 < 24)
                {
                    
                    if (_loc_6[pc2[_loc_8]])
                    {
                        _loc_4[_loc_10] = _loc_4[_loc_10] | bigbyte[_loc_8];
                    }
                    if (_loc_6[pc2[_loc_8 + 24]])
                    {
                        _loc_4[_loc_11] = _loc_4[_loc_11] | bigbyte[_loc_8];
                    }
                    _loc_8 = _loc_8 + 1;
                }
                _loc_9 = _loc_9 + 1;
            }
            _loc_9 = 0;
            while (_loc_9 != 32)
            {
                
                _loc_12 = _loc_4[_loc_9];
                _loc_13 = _loc_4[(_loc_9 + 1)];
                _loc_4[_loc_9] = (_loc_12 & 16515072) << 6 | (_loc_12 & 4032) << 10 | (_loc_13 & 16515072) >>> 10 | (_loc_13 & 4032) >>> 6;
                _loc_4[(_loc_9 + 1)] = (_loc_12 & 258048) << 12 | (_loc_12 & 63) << 16 | (_loc_13 & 258048) >>> 4 | _loc_13 & 63;
                _loc_9 = _loc_9 + 2;
            }
            return _loc_4;
        }// end function

        public function encrypt(param1:ByteArray, param2:uint = 0) : void
        {
            desFunc(encKey, param1, param2, param1, param2);
            return;
        }// end function

        public function decrypt(param1:ByteArray, param2:uint = 0) : void
        {
            desFunc(decKey, param1, param2, param1, param2);
            return;
        }// end function

        public function dispose() : void
        {
            var _loc_1:uint = 0;
            _loc_1 = 0;
            _loc_1 = 0;
            while (_loc_1 < encKey.length)
            {
                
                encKey[_loc_1] = 0;
                _loc_1 = _loc_1 + 1;
            }
            _loc_1 = 0;
            while (_loc_1 < decKey.length)
            {
                
                decKey[_loc_1] = 0;
                _loc_1 = _loc_1 + 1;
            }
            encKey = null;
            decKey = null;
            _loc_1 = 0;
            while (_loc_1 < key.length)
            {
                
                key[_loc_1] = 0;
                _loc_1 = _loc_1 + 1;
            }
            key.length = 0;
            key = null;
            Memory.gc();
            return;
        }// end function

        protected function desFunc(param1:Array, param2:ByteArray, param3:uint, param4:ByteArray, param5:uint) : void
        {
            var _loc_6:uint = 0;
            var _loc_7:uint = 0;
            var _loc_8:uint = 0;
            var _loc_9:uint = 0;
            var _loc_10:uint = 0;
            _loc_8 = (param2[param3 + 0] & 255) << 24;
            _loc_8 = _loc_8 | (param2[(param3 + 1)] & 255) << 16;
            _loc_8 = _loc_8 | (param2[param3 + 2] & 255) << 8;
            _loc_8 = _loc_8 | param2[param3 + 3] & 255;
            _loc_7 = (param2[param3 + 4] & 255) << 24;
            _loc_7 = _loc_7 | (param2[param3 + 5] & 255) << 16;
            _loc_7 = _loc_7 | (param2[param3 + 6] & 255) << 8;
            _loc_7 = _loc_7 | param2[param3 + 7] & 255;
            _loc_6 = (_loc_8 >>> 4 ^ _loc_7) & 252645135;
            _loc_7 = _loc_7 ^ _loc_6;
            _loc_8 = _loc_8 ^ _loc_6 << 4;
            _loc_6 = (_loc_8 >>> 16 ^ _loc_7) & 65535;
            _loc_7 = _loc_7 ^ _loc_6;
            _loc_8 = _loc_8 ^ _loc_6 << 16;
            _loc_6 = (_loc_7 >>> 2 ^ _loc_8) & 858993459;
            _loc_8 = _loc_8 ^ _loc_6;
            _loc_7 = _loc_7 ^ _loc_6 << 2;
            _loc_6 = (_loc_7 >>> 8 ^ _loc_8) & 16711935;
            _loc_8 = _loc_8 ^ _loc_6;
            _loc_7 = _loc_7 ^ _loc_6 << 8;
            _loc_7 = (_loc_7 << 1 | _loc_7 >>> 31 & 1) & 4294967295;
            _loc_6 = (_loc_8 ^ _loc_7) & 2863311530;
            _loc_8 = _loc_8 ^ _loc_6;
            _loc_7 = _loc_7 ^ _loc_6;
            _loc_8 = (_loc_8 << 1 | _loc_8 >>> 31 & 1) & 4294967295;
            _loc_9 = 0;
            while (_loc_9 < 8)
            {
                
                _loc_6 = _loc_7 << 28 | _loc_7 >>> 4;
                _loc_6 = _loc_6 ^ param1[_loc_9 * 4 + 0];
                _loc_10 = SP7[_loc_6 & 63];
                _loc_10 = _loc_10 | SP5[_loc_6 >>> 8 & 63];
                _loc_10 = _loc_10 | SP3[_loc_6 >>> 16 & 63];
                _loc_10 = _loc_10 | SP1[_loc_6 >>> 24 & 63];
                _loc_6 = _loc_7 ^ param1[_loc_9 * 4 + 1];
                _loc_10 = _loc_10 | SP8[_loc_6 & 63];
                _loc_10 = _loc_10 | SP6[_loc_6 >>> 8 & 63];
                _loc_10 = _loc_10 | SP4[_loc_6 >>> 16 & 63];
                _loc_10 = _loc_10 | SP2[_loc_6 >>> 24 & 63];
                _loc_8 = _loc_8 ^ _loc_10;
                _loc_6 = _loc_8 << 28 | _loc_8 >>> 4;
                _loc_6 = _loc_6 ^ param1[_loc_9 * 4 + 2];
                _loc_10 = SP7[_loc_6 & 63];
                _loc_10 = _loc_10 | SP5[_loc_6 >>> 8 & 63];
                _loc_10 = _loc_10 | SP3[_loc_6 >>> 16 & 63];
                _loc_10 = _loc_10 | SP1[_loc_6 >>> 24 & 63];
                _loc_6 = _loc_8 ^ param1[_loc_9 * 4 + 3];
                _loc_10 = _loc_10 | SP8[_loc_6 & 63];
                _loc_10 = _loc_10 | SP6[_loc_6 >>> 8 & 63];
                _loc_10 = _loc_10 | SP4[_loc_6 >>> 16 & 63];
                _loc_10 = _loc_10 | SP2[_loc_6 >>> 24 & 63];
                _loc_7 = _loc_7 ^ _loc_10;
                _loc_9 = _loc_9 + 1;
            }
            _loc_7 = _loc_7 << 31 | _loc_7 >>> 1;
            _loc_6 = (_loc_8 ^ _loc_7) & 2863311530;
            _loc_8 = _loc_8 ^ _loc_6;
            _loc_7 = _loc_7 ^ _loc_6;
            _loc_8 = _loc_8 << 31 | _loc_8 >>> 1;
            _loc_6 = (_loc_8 >>> 8 ^ _loc_7) & 16711935;
            _loc_7 = _loc_7 ^ _loc_6;
            _loc_8 = _loc_8 ^ _loc_6 << 8;
            _loc_6 = (_loc_8 >>> 2 ^ _loc_7) & 858993459;
            _loc_7 = _loc_7 ^ _loc_6;
            _loc_8 = _loc_8 ^ _loc_6 << 2;
            _loc_6 = (_loc_7 >>> 16 ^ _loc_8) & 65535;
            _loc_8 = _loc_8 ^ _loc_6;
            _loc_7 = _loc_7 ^ _loc_6 << 16;
            _loc_6 = (_loc_7 >>> 4 ^ _loc_8) & 252645135;
            _loc_8 = _loc_8 ^ _loc_6;
            _loc_7 = _loc_7 ^ _loc_6 << 4;
            param4[param5 + 0] = _loc_7 >>> 24 & 255;
            param4[(param5 + 1)] = _loc_7 >>> 16 & 255;
            param4[param5 + 2] = _loc_7 >>> 8 & 255;
            param4[param5 + 3] = _loc_7 & 255;
            param4[param5 + 4] = _loc_8 >>> 24 & 255;
            param4[param5 + 5] = _loc_8 >>> 16 & 255;
            param4[param5 + 6] = _loc_8 >>> 8 & 255;
            param4[param5 + 7] = _loc_8 & 255;
            return;
        }// end function

        public function toString() : String
        {
            return "des";
        }// end function

        public function getBlockSize() : uint
        {
            return 8;
        }// end function

    }
}
