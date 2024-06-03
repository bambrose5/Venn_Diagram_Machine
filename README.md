# Venn_Diagram_Machine

If you want to create a custom Venn diagram in R with a wide discrepancy between number of shared features, then Venn Diagram Machine is for you. I came upon a conundrum that required this solution when I found out R could only create a Venn diagram with custom colors so long as the number of shared featured determines the area of the overlaps. Imagine, 2 categories only share 1 feature and the largest category has 200
features. That would lead to quite the messy Venn diagram. Now, R already does have a package where the area of overlaps are unchanging no matter the number of shared
features. However, you cannot customize that Venn diagram! Venn Diagram Machine combines multiple different Venn Diagram packages to create the desired Venn diagram, 
in this case one where the area of the Venn diagram overlaps is not determined based by the the number of shared features and importantly now one that can be customized to your mind's desire.

Please note Venn Diagram Machine is set up to easily create a Venn diagram for 2-4 features. Given user feedback, the number of allowable categories can be increased in the future.
