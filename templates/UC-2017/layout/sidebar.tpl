{has_boxes position='left' assign='hasLeftBox'}
{if !$bExclusive && $hasLeftBox && isset($boxes) && !empty($boxes.left)}
    {$boxes.left}
{/if}
