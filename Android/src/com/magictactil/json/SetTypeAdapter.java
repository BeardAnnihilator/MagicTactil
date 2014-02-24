package com.magictactil.json;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.magictactil.model.Set;

class SetTypeAdapter implements JsonDeserializer<List<Set>> 
{
	@Override
    public List<Set> deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext ctx) throws JsonParseException
    {
        List<Set> vals = new ArrayList<Set>();
        if (json.isJsonArray()) 
        {
            for (JsonElement e : json.getAsJsonArray()) 
            {
                vals.add((Set) ctx.deserialize(e, Set.class));
            }
        } 
        else if (json.isJsonObject()) 
        {
            vals.add((Set) ctx.deserialize(json, Set.class));
        } 
        else 
        {
            throw new RuntimeException("Unexpected JSON type: " + json.getClass());
        }
        return vals;
    }
}