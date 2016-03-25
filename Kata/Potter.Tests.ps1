$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Potter" {
    It "costs nothing if basket is empty" {
        Calculate-Price @() | Should Be 0
    }
    
    It "should cost 8 for 1 book One" {
        Calculate-Price @(1) | Should Be 8
    }
    
    It "should cost 8 for 1 book Two" {
        Calculate-Price @(2) | Should Be 8
    }

    It "should cost 8 for 1 book Three" {
        Calculate-Price @(3) | Should Be 8
    }
    
    It "should cost 8 for 1 book Four" {
        Calculate-Price @(4) | Should Be 8
    }
    
    It "should cost 8 for 1 book Five" {
        Calculate-Price @(5) | Should Be 8
    }       
    
    It "should discount nothing for 2 identical books" {
        Calculate-Price @(1, 1) | Should Be (2 * 8)
    } 
    
    It "should discount nothing for 3 identical books" {
        Calculate-Price @(2, 2, 2) | Should Be (3 * 8)
    } 
    
    It "should discount 5% for 2 different books" {
        Calculate-Price @(1, 2) | Should Be (2 * 8 * 0.95)
    }
    
    It "should discount 10% for 3 different books" {
        Calculate-Price @(2, 3, 4) | Should Be (3 * 8 * 0.9)
    }
    
    It "should discount 20% for 4 different books" {
        Calculate-Price @(1, 2, 4, 5) | Should Be (4 * 8 * 0.8)
    }
    
    It "should discount 25% for 5 different books" {
        Calculate-Price @(1, 2, 3, 4, 5) | Should Be (5 * 8 * 0.75)
    }    
        
    It "should discount 5% for 2 different books out of 3" {
        Calculate-Price @(1, 2, 2) | Should Be (8 + 2 * 8 * 0.95)
    }

    It "should discount 5% for 2 pairs of different books" {
        Calculate-Price @(1, 2, 1, 2) | Should Be (2 * 2 * 8 * 0.95)
    }
    
    It "should discount 5% and 20% for 2 and 4 different books" {
        Calculate-Price @(1, 1, 2, 3, 3, 4) | Should Be (8 * 2 * 0.95 + 8 * 4 * 0.8)        
    }
    
    It "should discount 25% and nothing for 5 and 1 different books" {
        Calculate-Price @(1, 2, 2, 3, 4, 5) | Should Be (8 + 8 * 5 * 0.75)
    }
    
    # Edge case, does you code cover this one ?
    
    It "should be clever about grouping different books" {
        Calculate-Price @(1, 1, 2, 2, 3, 3, 4, 5) | Should Be (2 * 8 * 4 * 0.8)
    }
}
