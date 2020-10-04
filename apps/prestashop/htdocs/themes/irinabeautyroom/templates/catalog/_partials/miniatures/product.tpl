{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{block name='product_miniature_item'}
  <article class="product-miniature js-product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
    <div class="thumbnail-container">
      {block name='product_thumbnail'}
        {if empty($product.cover.bySize.home_default.url)}
          <a href="{$product.url}" class="thumbnail product-thumbnail">
            <img src = "{$urls.img_prod_url}{$language.iso_code}-default-home_default.jpg" alt = "{$product.cover.legend}" data-full-size-image-url = "{$product.cover.large.url}">
          </a>
        {else}
          {capture name='displayProductListGallery'}{hook h='displayProductListGallery' product=$product}{/capture}
          {if $smarty.capture.displayProductListGallery}
            {hook h='displayProductListGallery' product=$product}
          {else}
            <a href="{$product.url}" class="thumbnail product-thumbnail">
              <img src = "{$product.cover.bySize.home_default.url}" alt = "{$product.cover.legend}" data-full-size-image-url = "{$product.cover.large.url}">
            </a>
          {/if}
        {/if}
      {/block}

      <div class="product-description">
        <div class="left">
          {block name='product_name'}
            <h3 class="product-title" itemprop="name"><a href="{$product.url}">{$product.name|truncate:30:'...'}</a></h3>
          {/block}
          {block name='product_price_and_shipping'}
            {if $product.show_price}
              <div class="product-price-and-shipping">
                {hook h='displayProductPriceBlock' product=$product type="before_price"}
                <span class="sr-only">{l s='Price' d='Shop.Theme.Catalog'}</span>
                {if $product.has_discount}
                  <span itemprop="price" class="price new-price">{$product.price}</span>
                  {hook h='displayProductPriceBlock' product=$product type="old_price"}
                  <span class="sr-only">{l s='Regular price' d='Shop.Theme.Catalog'}</span>
                  <span class="regular-price">{$product.regular_price}</span>
                {else}
                  <span itemprop="price" class="price">{$product.price}</span>
                {/if}
                {hook h='displayProductPriceBlock' product=$product type='unit_price'}
                {hook h='displayProductPriceBlock' product=$product type='weight'}
              </div>
            {/if}
          {/block}
        </div>
        <div class="right">
           <div style="display:none">
            minimal_quantity: {$product.minimal_quantity}
            quantity:{$product.quantity}
           </div>
          {if !$configuration.is_catalog && $product.minimal_quantity <= $product.quantity}
            <form action="{$urls.pages.cart}" method="post">
              <div class="product-quantity" style="display:none;">
                <input type="hidden" name="token" value="{$static_token}">
                <input type="hidden" name="id_product" value="{$product.id_product}">
                <input type="hidden" name="id_customization" value="0">
                <input type="number" name="qty" value="1" class="input-group"  min="1"  />
              </div>
              {if $product.customizable == 0}
                <a href="javascript:void(0);" class="ajax_add_to_cart_button add-to-cart fl-chapps-hand135" data-button-action="add-to-cart"></a>
              {else}
                <a href="{$product.url}" class="customize fl-chapps-configuration13"></a>
              {/if}
            </form>
          {/if}
          {block name='product_reviews'}
            {hook h='displayProductListReviews' product=$product}
          {/block}
        </div>
      </div>

      {block name='product_flags'}
        {assign var=has_discount value=($product.show_price && $product.has_discount && $product.discount_type === 'percentage')}
        <ul class="product-flags">
          {foreach from=$product.flags item=flag}
            {if $flag.type !== 'on-sale' || !$has_discount}
              <li class="product-flag {$flag.type}">
                {$flag.label}
              </li>
            {/if}
          {/foreach}
          {if $has_discount}
            <li class="product-flag on-sale">
              {$product.discount_percentage}
            </li>
          {/if}
          {if $product->quantity == 0 AND $quantity == 0}
        <li class="etiqueta-roja">
        {l s="Sin Stock" d="Shop.Theme.Catalog"}

        {/if}
        </ul>
      {/block}

      {block name='quick_view'}
        <a class="quick-view fl-chapps-eye95" href="#" data-link-action="quickview"></a>
      {/block}
    </div>



  </article>
{/block}
